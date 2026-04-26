# Cloudformation

Yes, CloudFormation works excellently with MiniStack. Since MiniStack is "drop-in" compatible, the logic is identical to how you handled Terraform: you just point the AWS CLI to your local endpoint.

In 2026, MiniStack uses a "Modern Engine" that handles the same YAML or JSON templates you'd use in production.

### 1. The CloudFormation Template (`template.yaml`)
Create a file named `template.yaml`. This template mirrors your Terraform setup: an S3 bucket and a Secrets Manager secret.

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: Lab infrastructure for S3 and Secrets Manager.

Resources:
  # 1. The S3 Bucket
  LabBucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: killercoda-cfn-storage

  # 2. The KMS Key (Optional, but good for "Vault" practice)
  VaultKey:
    Type: AWS::KMS::Key
    Properties:
      Description: Key for local vault encryption
      KeyPolicy:
        Version: '2012-10-17'
        Statement:
          - Sid: Enable IAM User Permissions
            Effect: Allow
            Principal:
              AWS: !Sub 'arn:aws:iam::${AWS::AccountId}:root'
            Action: 'kms:*'
            Resource: '*'

  # 3. The "Vault" (Secrets Manager Secret)
  AppSecretVault:
    Type: AWS::SecretsManager::Secret
    Properties:
      Name: my-cfn-app-vault
      Description: "Secrets stored via CloudFormation"
      KmsKeyId: !Ref VaultKey
      SecretString: '{"api_key":"CFN_SECRET_12345"}'

Outputs:
  BucketName:
    Value: !Ref LabBucket
  SecretARN:
    Value: !Ref AppSecretVault
```

---

### 2. Deploying to MiniStack
To deploy this, you use the standard `aws cloudformation deploy` command, but you must include the `--endpoint-url`.

**Run this in your terminal:**
```bash
aws --endpoint-url=http://localhost:4566 \
    cloudformation deploy \
    --stack-name my-lab-stack \
    --template-file template.yaml
```

### 3. Verifying the Deployment
CloudFormation in MiniStack isn't just a "mock"—it actually creates the underlying resources. You can check the stack status and the resources it created:

**Check Stack Status:**
```bash
aws --endpoint-url=http://localhost:4566 cloudformation describe-stacks --stack-name my-lab-stack
```

**Check the Bucket:**
```bash
aws --endpoint-url=http://localhost:4566 s3 ls
```

---

### Key Differences from Terraform
* **No "Path Style" Worries:** Unlike the Terraform provider which requires a manual flag for S3 path-style, the CloudFormation engine inside MiniStack handles the internal resource creation automatically. You don't need to configure "path-style" in the YAML template itself.
* **State Management:** While Terraform keeps a local `.tfstate` file, CloudFormation stores the "state" inside MiniStack itself. If you run `docker-compose down` without persistence, your CloudFormation stack is gone.
* **Rollbacks:** In the 2026 version of MiniStack, if your YAML has a syntax error, it will actually attempt a "ROLLBACK_COMPLETE," just like real AWS.

### Pro-Tip: The "awslocal" Alias
If you find yourself doing this a lot in Killercoda, remember to set that alias we talked about earlier:
`alias awslocal='aws --endpoint-url=http://localhost:4566'`

Then your command becomes much cleaner:
`awslocal cloudformation deploy --stack-name my-stack --template-file template.yaml`

Would you like to see how to integrate a **Lambda function** into this CloudFormation template next?
---


# Cloud stack admin



To manage your CloudFormation stacks in MiniStack, you'll use the same AWS CLI commands you'd use for a real AWS environment—just remember to prepend your endpoint URL.

Assuming you're using the `awslocal` alias we set up earlier (`alias awslocal='aws --endpoint-url=http://localhost:4566'`), here is your administration toolkit:

### 1. Basic Visibility (What's running?)
Before changing anything, you need to see what exists in your local environment.

* **List all stacks:**
  ```bash
  awslocal cloudformation list-stacks --stack-status-filter CREATE_COMPLETE ROLLBACK_COMPLETE
  ```
* **Get stack details (Outputs & Status):**
  ```bash
  awslocal cloudformation describe-stacks --stack-name lambda-stack
  ```
* **List specific resources in a stack (S3 Buckets, IAM Roles, etc):**
  ```bash
  awslocal cloudformation list-stack-resources --stack-name lambda-stack
  ```

### 2. Updating Your Stack
If you change your `lambda-template.yaml` (e.g., changing the memory limit or adding a new secret), use the `deploy` command again. CloudFormation is smart enough to perform an **Update** instead of a new **Create**.

* **Update existing stack:**
  ```bash
  awslocal cloudformation deploy \
      --template-file lambda-lab/lambda-template.yaml \
      --stack-name lambda-stack \
      --capabilities CAPABILITY_IAM
  ```

### 3. Troubleshooting & Recovery
Sometimes a deployment fails (e.g., a typo in your YAML). You need to see the "Events" to know why.

* **View deployment logs/events:**
  ```bash
  awslocal cloudformation describe-stack-events --stack-name lambda-stack
  ```
* **Retrieve the original template from the stack:**
  ```bash
  awslocal cloudformation get-template --stack-name lambda-stack
  ```

### 4. Destruction (Housekeeping)
When the lab is over or you want to start fresh, delete the resources to free up MiniStack's memory.

* **Delete the stack:**
  ```bash
  awslocal cloudformation delete-stack --stack-name lambda-stack
  ```
  *(Note: This doesn't return an error if it succeeds; it just starts the deletion process in the background.)*

* **Wait for deletion to finish:**
  ```bash
  awslocal cloudformation wait stack-delete-complete --stack-name lambda-stack
  ```

---

### Pro-Tip: Inspecting the "Physical" Resource
If you want to verify the resource exists outside of CloudFormation's "logic," use the specific service CLI. For example, if your stack created a Lambda:

```bash
# CloudFormation calls it 'MyHelloFunction' (Logical ID)
# But what is its real name in the Lambda service?
awslocal lambda list-functions
```

Since you're running this in **Killercoda**, remember that these commands only work while the MiniStack container is up. If you restart the container without a volume mount, these "stacks" will vanish from the internal database!
