
Using ministack build a killacoda lab for using Cloudformation


---

gemini: "Here is the complete step-by-step blueprint for your Killercoda lab environment."
---

## Lab Overview & Setup

* **Estimated Time:** 45–60 minutes
* **Workspace Setup:**
* Left Panel: Terminal & VS Code editor
* Right Panel: Lab Instructions
* Background script automatically spins up MiniStack and configures the AWS CLI to point to `http://localhost:4566` (or your specific MiniStack port) using dummy credentials.



---

## Part 1: The Zero-to-Hero Lifecycle

*Goal: Write, validate, and deploy a foundational stack.*

### Step 1.1: Write the Base Template

Instruct the user to open the IDE and create a file named `infrastructure.yaml`. They will write a basic template defining an S3 Bucket and an SQS Queue.

* **Action:** Create `infrastructure.yaml` with standard `AWSTemplateFormatVersion: '2010-09-09'` and basic `Resources` blocks.

### Step 1.2: Static Validation

Before deploying, teach them to use the native validation API against MiniStack to catch syntax issues.

* **Command:**
```bash
aws cloudformation validate-template --template-body file://infrastructure.yaml

```



```

### Step 1.3: Deploy the Stack
Launch the resources locally.
* **Command:**
  ```bash
  aws cloudformation create-stack --stack-name local-core-infra --template-body file://infrastructure.yaml

```

* **Verification:** Run `aws cloudformation wait stack-create-complete --stack-name local-core-infra` to simulate waiting for a live cloud deployment.

### Step 1.4: Verify Local Resource Creation

Prove to the user that MiniStack actually provisioned the assets by querying the service APIs directly.

* **Commands:**
```bash
aws s3api list-buckets
aws sqs list-queues

```



```

---

## Part 2: Dynamic Templates (Functions & Parameters)
*Goal: Evolve the static template using variables and cross-resource references.*

### Step 2.1: Add Parameters and Intrinsic Functions
Have the user modify `infrastructure.yaml` to include a `Parameters` block for `EnvironmentType` (`Dev` or `Prod`). They will use `!Sub` or `!Ref` to dynamically name the S3 bucket based on the parameter input.
* **Action:** Add an SNS Topic to the template and use `!Ref` or `!GetAtt` to wire its subscription metadata to the existing SQS queue.

### Step 2.2: Add Stack Outputs
Instruct them to add an `Outputs` section that prints the generated SQS Queue URL and S3 Bucket Domain Name.

### Step 2.3: Perform a Stack Update
Deploy the changes by passing a parameter file or an inline parameter flag.
* **Command:**
  ```bash
  aws cloudformation update-stack --stack-name local-core-infra --template-body file://infrastructure.yaml --parameters ParameterKey=EnvironmentType,ParameterValue=Dev

```

### Step 2.4: Inspect Outputs

Verify that the outputs are generated correctly in the terminal.

* **Command:**
```bash
aws cloudformation describe-stacks --stack-name local-core-infra --query "Stacks[0].Outputs"

```



```

---

## Part 3: Simulating Event-Driven Architecture
*Goal: Test plumbing logic by routing a live event through the CloudFormation-backed stack.*

### Step 3.1: Add EventBridge and CloudWatch to the Template
Have the user add an EventBridge (CloudWatch Events) Rule and a CloudWatch Log Group to `infrastructure.yaml`. The rule should filter for a specific custom event source and target the SQS queue or Log Group.

### Step 3.2: Update the Stack
Apply the new architectural plumbing to the local emulator.
* **Command:**
  ```bash
  aws cloudformation update-stack --stack-name local-core-infra --template-body file://infrastructure.yaml --parameters ParameterKey=EnvironmentType,ParameterValue=Dev

```

### Step 3.3: Fire a Test Payload

Simulate an application event by publishing a matching payload directly to the local EventBridge bus using the CLI.

* **Command:**
```bash
aws events put-events --entries '[{"Source": "my.local.app", "DetailType": "UserSignUp", "Detail": "{\"user\": \"alice\"}"}]'

```



```

### Step 3.4: Tail the Local Logs
Verify that the CloudFormation routing configuration works by checking if the message landed successfully in the SQS queue or the CloudWatch log stream.
* **Command:**
  ```bash
  aws sqs receive-message --queue-url <Output_Queue_URL>

```

---

## Part 4: Drift Detection & Remediation

*Goal: Learn troubleshooting workflows when configuration state diverges from code.*

### Step 4.1: Simulate "Configuration Drift" (The Sabotage)

Instruct the user to bypass CloudFormation entirely and manually alter a resource property using the direct service CLI. For example, change a configuration tag or an SQS queue attribute behind CloudFormation's back.

* **Command:**
```bash
aws sqs set-queue-attributes --queue-url <Output_Queue_URL> --attributes VisibilityTimeout=60

```



```

### Step 4.2: Trigger Drift Detection
Have the user ask CloudFormation to evaluate whether the live state matches the original blueprint template.
* **Commands:**
  ```bash
  # Start detection
  aws cloudformation detect-stack-drift --stack-name local-core-infra
  
  # Check the status and view the differences
  aws cloudformation describe-stack-resource-drifts --stack-name local-core-infra

```

### Step 4.3: Remediate the Stack

Teach the student how to resolve drift. They will update their `infrastructure.yaml` text file to match the new reality (`VisibilityTimeout: 60`), running an `update-stack` command to bring the stack back into a clean, synchronized state.

* **Command:**
```bash
aws cloudformation update-stack --stack-name local-core-infra --template-body file://infrastructure.yaml --parameters ParameterKey=EnvironmentType,ParameterValue=Dev

```



```

### Step 4.4: Final Status Verification
Confirm the stack is completely healthy and in sync.
* **Command:**
  ```bash
  aws cloudformation detect-stack-drift --stack-name local-core-infra

```

---

## Lab Conclusion

* **Summary:** Review what was accomplished: writing templates, utilizing functions, wiring up an asynchronous event pipeline, and managing state divergence—all completed in under an hour without touching a live cloud account.
* **Cleanup Command (Optional but good practice):**
```bash

```



---

## Lab Step Mapping (Implementation Tracker)

| Step | Topic | Blueprint Alignment | Status |
| :--- | :--- | :--- | :--- |
| **1** | **Initial Setup** | Infrastructure Setup | ✅ Completed |
| **2** | **The Zero-to-Hero Lifecycle** | Part 1: Lifecycle | ✅ Completed |
| **3** | **Dynamic Infrastructure** | Part 2.1: Parameters | ✅ Completed |
| **4** | **Wiring & Outputs** | Part 2.2 - 2.4: Refs/Outputs | ✅ Completed |
| **5** | **Event-Driven Plumbing** | Part 3.1 - 3.2: EventBridge | ✅ Completed |
| **6** | **Simulating the Pipeline** | Part 3.3 - 3.4: Verification | ✅ Completed |
| **7** | **Drift & Remediation** | Part 4: Drift Detection | ✅ Completed |

### Implementation Strategy
- **Step 2:** Focus on `validate-template` and `create-stack`.
- **Step 3/4:** Transition to dynamic templates using `Parameters` and `Intrinsic Functions`.
- **Step 5/6:** Demonstrate architectural wiring with EventBridge and SQS.
- **Step 7:** Practical exercise in identifying and fixing "Configuration Drift".