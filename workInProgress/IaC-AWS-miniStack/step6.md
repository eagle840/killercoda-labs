# AWS Sam

The **AWS Serverless Application Model (SAM)** is an open-source framework designed specifically to make building and running serverless applications faster and easier. If the AWS CLI is a Swiss Army knife, SAM is a specialized power tool for **Lambda**, **API Gateway**, and **DynamoDB**.

At its core, SAM consists of two parts: a **shorthand syntax** for defining infrastructure and a **powerful CLI** for local development.

### 1. The SAM Template (The "Shorthand")
SAM is built on top of CloudFormation. While standard CloudFormation is notoriously verbose, SAM allows you to define complex resources in just a few lines of YAML.
*   **Transformation:** You add `Transform: AWS::Serverless-2016-10-31` to the top of your file. This tells AWS to "expand" your simple SAM code into full CloudFormation during deployment.
*   **Example:** Defining a Lambda function with an API endpoint and a DynamoDB table takes about **20 lines in SAM** vs. **100+ lines in raw CloudFormation**.

### 2. The SAM CLI (The "Local Engine")
The CLI is where SAM really shines for your "Ministack" workflow. It uses **Docker** to create a local environment that mimics AWS.

*   **`sam local start-api`**: Creates a local HTTP server. When you hit `localhost:3000/hello`, it spins up a Docker container, runs your Lambda code, and returns the response.
*   **`sam local invoke`**: Directly triggers a function one time with a mock event (e.g., "pretend an S3 file was uploaded").
*   **`sam build`**: Automatically handles your dependencies (like `npm install` or `pip install`) and packages them correctly for the cloud.
*   **`sam sync --watch`**: This is a "hot reload" feature. As you save your code, SAM automatically updates your environment in the cloud (or LocalStack) almost instantly.

### 3. SAM vs. CDK: Which should you use?
Since you are looking at local CI/CD, the choice usually comes down to how you prefer to write code:

| Feature | AWS SAM | AWS CDK |
| :--- | :--- | :--- |
| **Language** | Declarative (YAML/JSON) | Imperative (Python, TS, Go, etc.) |
| **Best For** | Pure Serverless (Lambda, API) | Complex Infra (VPCs, RDS, EKS) |
| **Local Testing** | Built-in and native | Uses SAM CLI under the hood |
| **Learning Curve** | Low (if you know YAML) | Medium (requires coding logic) |

---

# Install



`curl -L "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip" -o "aws-sam-cli-linux-x86_64.zip"`{{exec}}

`unzip aws-sam-cli-linux-x86_64.zip -d sam-installation`{{exec}}

`sudo ./sam-installation/install`{{exec}}

`sam --version`{{exec}}

`docker ps`{{exec}}

# Hello World

https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started-hello-world.html

## Update node js

`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash`{{exec}}

```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```{{exec}}

`nvm install --lts`{{exec}}

`node --version`{{exec}}

## Start Sam

`cd ~`{{exec}}

`sam init`{{exec}}

cd to new folder

`sam local -h`{{exec}}


`sam build`{{exec}}

`sam validate`{{exec}}

`sam local invoke`{{exec}}

# syncb with localstack

```
export AWS_ENDPOINT_URL=http://localhost:4566
sam sync --watch --stack-name local-stack --capabilities CAPABILITY_IAM
```{{exec}}


You'll get an error:

```text
CloudFormation events from stack operations (refresh every 0.5 seconds)
-----------------------------------------------------------------------------------------------------------------------------------------
ResourceStatus                     ResourceType                       LogicalResourceId                  ResourceStatusReason             
-----------------------------------------------------------------------------------------------------------------------------------------
CREATE_IN_PROGRESS                 AWS::CloudFormation::Stack         local-stack                                                         
CREATE_IN_PROGRESS                 AWS::CloudFormation::Stack         AwsSamAutoDependencyLayerNestedS                                    
                                                                      tack                                                                
CREATE_FAILED                      AWS::Serverless::Function          HelloWorldFunction                 Unsupported resource type:       
                                                                                                         AWS::Serverless::Function        
CREATE_IN_PROGRESS                 AWS::Serverless::Function          HelloWorldFunction                                                  
CREATE_COMPLETE                    AWS::CloudFormation::Stack         AwsSamAutoDependencyLayerNestedS                                    
                                                                      tack                                                                
ROLLBACK_COMPLETE                  AWS::CloudFormation::Stack         local-stack                        Rollback complete                
-----------------------------------------------------------------------------------------------------------------------------------------

Failed to create/update the stack: local-stack, Waiter StackCreateComplete failed: Waiter encountered a terminal failure state: For         
expression "Stacks[].StackStatus" we matched expected path: "ROLLBACK_COMPLETE" at least once       
```

This error is a classic "Translation" failure. In the AWS world, SAM templates are just shorthand. Before AWS can use them, a **Transform** process turns `AWS::Serverless::Function` into standard `AWS::Lambda::Function` and `AWS::IAM::Role` resources.

The error `Unsupported resource type: AWS::Serverless::Function` means your local Ministack/LocalStack received the shorthand but didn't know how to "expand" it into the real resources.

### Why this is happening
1.  **The Transform Header is Missing:** Your `template.yaml` must have `Transform: AWS::Serverless-2016-10-31` at the very top. Without this, CloudFormation (even locally) doesn't know it's a SAM template and treats it as a standard template where `AWS::Serverless::Function` doesn't exist.
2.  **Ministack Version:** If you are using a very lightweight or older version of an emulator, it might not support the "Serverless Transform" natively.
3.  **The "Sync" didn't Build first:** `sam sync` usually handles this, but if there was a glitch in the build phase, it might be sending the raw YAML instead of the transformed JSON.

---

### How to Fix It

#### Step 1: Check your Template Header
Ensure your `template.yaml` starts exactly like this:
```yaml
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31  # <--- THIS IS CRITICAL
Description: My local stack
```

#### Step 2: Use `sam build` before syncing
Sometimes the local emulator struggles to transform the template on the fly. Force a build first to create the "expanded" version in the `.aws-sam` folder:
```bash
sam build
samlocal sync --watch --stack-name local-stack
```

#### Step 3: Check if your Ministack supports the Transform
If you are using the open-source version of **MiniStack**, it sometimes requires you to be running in a mode that supports the SAM translator. 
*   **For LocalStack users:** If you see this, it often means your LocalStack container needs to pull the "SAM Local" image. Make sure your Docker has internet access to download the runtime support.

#### Step 4: The "Bypass" (Manual Build)
If the emulator refuses to do the transform, you can do it yourself using the SAM CLI and then point the deploy to the result:
1.  Run `sam build`
2.  The "transformed" template is now in `.aws-sam/build/template.yaml`.
3.  Try to sync using that specific file:
    ```bash
    samlocal sync --template .aws-sam/build/template.yaml --stack-name local-stack
    ```

### Summary of the "Rollback"
The reason you see `ROLLBACK_COMPLETE` at the end of your log is that CloudFormation is "all or nothing." Because the `HelloWorldFunction` failed to create, it deleted the `local-stack` to keep your environment clean.

**Does your `template.yaml` have that `Transform` line at the top?**

---

# IAM  (WIP this isn't sam - perhaps a new step? )

Using **MiniStack** to explore **Identity and Access Management (IAM)** is a brilliant move for local development. Since MiniStack is a lightweight alternative to LocalStack, it allows you to simulate AWS IAM without the fear of accidentally locking yourself out of a real account or racking up costs.

In MiniStack, IAM serves the same purpose as it does in AWS: defining **who** (Users/Roles) can do **what** (Policies) on **which** resources.

---

## 1. The Core IAM Workflow in MiniStack
Even though MiniStack is local, it validates the structure of your IAM entities. You generally follow this flow:
1. **Create a User/Role:** The identity that will perform actions.
2. **Define a Policy:** A JSON document specifying allowed/denied actions.
3. **Attach the Policy:** Binding the permission to the identity.



---

## 2. Practical Hands-on with MiniStack
Assuming you have MiniStack running (typically on `http://localhost:4566`), you can use the AWS CLI to practice.

### A. Create a "Developer" User
First, let's create a virtual user within your local environment.
```bash
aws --endpoint-url=http://localhost:4566 iam create-user --user-name DevUser
```{{exec}}

### B. Create and Attach a Policy
Let's say you want this user to only have Read-Only access to S3. You would create a `policy.json` file:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["s3:Get*", "s3:List*"],
            "Resource": "*"
        }
    ]
}
```{{copy}}

Then, apply it in MiniStack:

```bash
aws --endpoint-url=http://localhost:4566 iam create-policy \
    --policy-name S3ReadOnly \
    --policy-document file://policy.json

# Attach it to the user
aws --endpoint-url=http://localhost:4566 iam attach-user-policy \
    --user-name DevUser \
    --policy-arn arn:aws:iam::000000000000:policy/S3ReadOnly
```{{exec}}

---

## 3. Why Use IAM in MiniStack?
You might wonder, *"If it's just local, why bother with permissions?"* * **Testing Code Logic:** If your application code uses `boto3` or the AWS SDK, you can test how it handles `AccessDenied` errors by intentionally giving your local "mock" user restricted permissions.
* **Terraform Validation:** You can run `terraform apply` against MiniStack to ensure your IAM modules are syntactically correct and the ARNs (Amazon Resource Names) are being generated as expected.
* **Role Assumption:** You can practice **AssumeRole** logic, which is crucial for cross-account access or giving temporary permissions to Lambda functions.

### Quick Tip: The "Magic" Account ID
By default, MiniStack (like LocalStack) often uses `000000000000` as the default Account ID. When you see ARNs like `arn:aws:iam::000000000000:user/DevUser`, that's your local "mock" account!

Are you planning to use MiniStack primarily for manual CLI testing, or are you trying to integrate it into a CI/CD pipeline with something like Terraform?