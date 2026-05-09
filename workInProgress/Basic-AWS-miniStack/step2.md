
# IAM  

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


## ORG's Roots, OU, and accounts

