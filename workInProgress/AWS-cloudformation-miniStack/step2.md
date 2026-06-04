# Initial Lifecycle: Write, Validate, Deploy

In this step, you'll move from manual CLI commands to **Infrastructure as Code (IaC)**. You'll author a CloudFormation template, validate its syntax, and deploy it to MiniStack.

### 1. Create the Base Template
Create a file named `infrastructure.yaml` in your workspace. We'll start with two simple resources: an S3 Bucket and an SQS Queue.

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: Foundational local infrastructure.

Resources:
  # 1. The Storage Bucket
  LocalDataBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: local-lab-bucket

  # 2. The Message Queue
  LocalWorkQueue:
    Type: AWS::SQS::Queue
    Properties:
      QueueName: local-lab-queue
```{{copy}}

> **Tip:** In the Killercoda editor, you can right-click the file explorer to create a new file or use the terminal.

### 2. Static Validation
Before deploying, use the validation API to ensure your YAML is syntactically correct and follows the CloudFormation schema.

```bash
awslocal cloudformation validate-template --template-body file://infrastructure.yaml
```{{exec}}

### 3. Deploy the Stack
Now, launch the resources. We'll use the `create-stack` command for this initial deployment.

```bash
awslocal cloudformation create-stack \
  --stack-name local-core-infra \
  --template-body file://infrastructure.yaml
```{{exec}}

In a real cloud environment, resources take time to provision. You can simulate the "wait" workflow here:

```bash
awslocal cloudformation wait stack-create-complete --stack-name local-core-infra
```{{exec}}

### 4. Verify Local Resource Creation
Prove that MiniStack actually provisioned the assets by querying the service APIs directly. Unlike the "logical" view in CloudFormation, these commands show the "physical" reality.

**List Buckets:**
```bash
awslocal s3api list-buckets
```{{exec}}

**List Queues:**
```bash
awslocal sqs list-queues
```{{exec}}
