# Dynamic Templates: Parameters & Functions

Static templates are useful, but real-world infrastructure needs to be flexible. In this step, you'll learn how to use **Parameters** and **Intrinsic Functions** to make your blueprint adaptable to different environments (like `Dev` or `Prod`).

### 1. Add Parameters
Modify your `infrastructure.yaml` to include a `Parameters` block. This allows you to pass values into the template at runtime.

Add this block at the top, just below the `Description`:

```yaml
Parameters:
  EnvironmentType:
    Type: String
    Default: dev
    AllowedValues: [dev, prod]
    Description: Enter dev or prod.
```{{copy}}

### 2. Use Intrinsic Functions
Now, let's use the `!Sub` (Substitute) function to dynamically name the S3 bucket based on the environment parameter.

Update the `LocalDataBucket` resource in your `infrastructure.yaml`:

```yaml
  LocalDataBucket:
    Type: AWS::S3::Bucket
    Properties:
      # This dynamically creates: local-lab-bucket-dev or local-lab-bucket-prod
      BucketName: !Sub 'local-lab-bucket-${EnvironmentType}'
```{{copy}}

### 3. Perform a Stack Update
Since the stack `local-core-infra` already exists, we use the `update-stack` command to apply these changes. We'll pass the `EnvironmentType` parameter via the CLI.

```bash
awslocal cloudformation update-stack \
  --stack-name local-core-infra \
  --template-body file://infrastructure.yaml \
  --parameters ParameterKey=EnvironmentType,ParameterValue=dev
```{{exec}}

### 4. Verify the Dynamic Change
Check if CloudFormation successfully renamed (re-created) the bucket to include the `-dev` suffix.

```bash
awslocal s3api list-buckets
```{{exec}}

> **Note:** In CloudFormation, some property changes (like `BucketName`) require the resource to be replaced. Notice how the old bucket name is gone and the new one exists.

### 5. Inspect the Stack Parameters
You can verify which parameters are currently applied to your stack:

```bash
awslocal cloudformation describe-stacks \
  --stack-name local-core-infra \
  --query "Stacks[0].Parameters"
```{{exec}}
