# Lambda

This is where things get interesting. In a local emulator like MiniStack, you have two ways to deploy Lambda code via CloudFormation:

1.  **Inline Code:** Perfect for small scripts (Python/Node). You write the code directly in the YAML.
2.  **S3 Upload:** More realistic. You zip your code, upload it to an S3 bucket, and point CloudFormation to that bucket.

Since this is for a lab, I'll show you the **Inline** method first because it's the easiest to get running, and then how to do the **S3** method for a more "pro" experience.

### Option 1: Inline Lambda (Simplest)
Create a new folder called `lambda-lab` and put this `lambda-template.yaml` inside it.

**`lambda-lab/lambda-template.yaml`**
```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: Simple Inline Lambda Lab

Resources:
  # 1. IAM Role for Lambda (MiniStack doesn't strictly enforce policies, but requires the resource)
  LambdaExecutionRole:
    Type: AWS::IAM::Role
    Properties:
      AssumeRolePolicyDocument:
        Version: '2012-10-17'
        Statement:
          - Effect: Allow
            Principal:
              Service: lambda.amazonaws.com
            Action: sts:AssumeRole
      ManagedPolicyArns:
        - arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

  # 2. The Lambda Function
  MyHelloFunction:
    Type: AWS::Lambda::Function
    Properties:
      FunctionName: hello-killercoda
      Handler: index.handler
      Role: !GetAtt LambdaExecutionRole.Arn
      Runtime: python3.9
      Code:
        ZipFile: |
          import json
          def handler(event, context):
              print("Hello from Killercoda!")
              return {
                  'statusCode': 200,
                  'body': json.dumps('Hello from MiniStack!')
              }

Outputs:
  FunctionName:
    Value: !Ref MyHelloFunction
```

**Deploy it:**
```bash
awslocal cloudformation deploy \
    --template-file lambda-lab/lambda-template.yaml \
    --stack-name lambda-stack \
    --capabilities CAPABILITY_IAM
```

---

### Option 2: The "S3 Zip" Method (More Realistic)
If your code is in a separate file (e.g., `index.py`), you need to zip it and upload it first.

1.  **Create the code file:**
    ```bash
    echo "def handler(event, context): return {'body': 'Zip deploy works!'}" > index.py
    zip function.zip index.py
    ```

2.  **Upload to your S3 bucket:** (Using the bucket we created earlier)
    ```bash
    awslocal s3 cp function.zip s3://killercoda-lab-storage/v1/function.zip
    ```

3.  **Update your template:**
    Instead of `ZipFile: |`, change the `Code` block in your YAML to:
    ```yaml
    Code:
      S3Bucket: killercoda-lab-storage
      S3Key: v1/function.zip
    ```

---

### How to test your Lambda
Once deployed, you can trigger it directly from the CLI to see the output.

**Invoke the function:**
```bash
awslocal lambda invoke --function-name hello-killercoda output.json
```

**View the response:**
```bash
cat output.json
```

### Housekeeping for Lambdas
* **Logs:** In MiniStack, your Lambda logs aren't just in the container logs; they go to **CloudWatch Logs**. You can see them with:
    ```bash
    awslocal logs describe-log-groups
    awslocal logs tail /aws/lambda/hello-killercoda
    ```
* **Cleanup:** If you want to delete the whole stack and the function:
    ```bash
    awslocal cloudformation delete-stack --stack-name lambda-stack
    ```

**Which method fits your lab better?** Inline is great for "Coding 101," but the S3 method is better if you're teaching "CI/CD and Deployment Pipelines."