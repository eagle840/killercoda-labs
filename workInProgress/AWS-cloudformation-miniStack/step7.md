# Drift Detection & Remediation

In the real world, someone might manually change a resource in the AWS Console, bypassing your CloudFormation code. This is called **Configuration Drift**. In this final step, you'll learn how to detect and fix it.

### 1. Simulate the "Sabotage"
We'll manually change the `VisibilityTimeout` of our SQS queue using the direct service CLI, without updating our CloudFormation template.

First, get your Queue URL again:
```bash
QUEUE_URL=$(awslocal cloudformation describe-stacks \
  --stack-name local-core-infra \
  --query "Stacks[0].Outputs[?OutputKey=='QueueURL'].OutputValue" \
  --output text)
```{{exec}}

Now, manually change the timeout to **60 seconds** (the default is usually 30):
```bash
awslocal sqs set-queue-attributes \
  --queue-url $QUEUE_URL \
  --attributes VisibilityTimeout=60
```{{exec}}

### 2. Trigger Drift Detection
Ask CloudFormation to compare the "live" state of the resources against the "blueprint" (your template).

```bash
# Start the detection process
awslocal cloudformation detect-stack-drift --stack-name local-core-infra
```{{exec}}

Now, view the results to see what has diverged:
```bash
awslocal cloudformation describe-stack-resource-drifts --stack-name local-core-infra
```{{exec}}

> **Observation:** You should see that the SQS queue is marked as `MODIFIED` because the `VisibilityTimeout` no longer matches the template.

### 3. Remediate the Stack
To fix drift, you should **never** just change it back manually. You should update your code to match the new reality (or force the code back to the original state).

Update the `LocalWorkQueue` in your `infrastructure.yaml` to include the new timeout:

```yaml
  LocalWorkQueue:
    Type: AWS::SQS::Queue
    Properties:
      QueueName: local-lab-queue
      VisibilityTimeout: 60
```{{copy}}

### 4. Re-sync the Stack
Run an `update-stack` to bring the stack back into a clean, "In-Sync" state.

```bash
awslocal cloudformation update-stack \
  --stack-name local-core-infra \
  --template-body file://infrastructure.yaml \
  --parameters ParameterKey=EnvironmentType,ParameterValue=dev
```{{exec}}

### 5. Final Verification
Run drift detection one last time to confirm everything is healthy.

```bash
awslocal cloudformation detect-stack-drift --stack-name local-core-infra
awslocal cloudformation describe-stack-resource-drifts \
  --stack-name local-core-infra \
  --query "StackResourceDrifts[?StackResourceDriftStatus!='IN_SYNC']"
```{{exec}}

If the output is an empty list `[]`, congratulations! Your infrastructure is fully synchronized with your code.
