# Serverless Compute (Lambda)

In this step, we'll create the "Glue" of our architecture. We'll deploy a Lambda function that triggers automatically when a file is uploaded to S3, and then sends a notification to an SQS queue.

### 1. Create the SQS Destination
First, we need a queue for our Lambda to talk to.

```bash
awslocal sqs create-queue --queue-name lambda-alerts
```{{exec}}

### 2. The Integrated Lambda
We will use the **Inline** method to deploy a Python function that parses S3 metadata and alerts SQS.

`mkdir -p ~/lambda-lab && cd ~/lambda-lab`{{exec}}

```bash
cat <<EOF > integration-template.yml
AWSTemplateFormatVersion: '2010-09-09'
Resources:
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
        - arn:aws:iam::aws:policy/AmazonSQSFullAccess

  S3ProcessorFunction:
    Type: AWS::Lambda::Function
    Properties:
      FunctionName: s3-to-sqs-logger
      Handler: index.handler
      Role: !GetAtt LambdaExecutionRole.Arn
      Runtime: python3.9
      Code:
        ZipFile: |
          import json
          import boto3
          import os

          sqs = boto3.client('sqs', endpoint_url='http://' + os.environ['LOCALSTACK_HOSTNAME'] + ':4566')

          def handler(event, context):
              # Get the object key from the S3 event
              for record in event.get('Records', []):
                  bucket = record['s3']['bucket']['name']
                  key = record['s3']['object']['key']
                  print(f"File uploaded: {key} to {bucket}")
                  
                  # Send a message to SQS
                  sqs.send_message(
                      QueueUrl='http://localhost:4566/000000000000/lambda-alerts',
                      MessageBody=f"ALERT: New file {key} detected in {bucket}!"
                  )
              return {'statusCode': 200}
EOF
```{{exec}}

**Deploy the Stack:**
```bash
awslocal cloudformation deploy \
    --template-file integration-template.yml \
    --stack-name integration-stack \
    --capabilities CAPABILITY_IAM
```{{exec}}

---

### 3. Connect S3 to Lambda
Now, tell S3 to "ping" the Lambda function whenever a `.txt` file is created.

```bash
awslocal s3api put-bucket-notification-configuration \
    --bucket integration-bucket \
    --notification-configuration '{
        "LambdaFunctionConfigurations": [
            {
                "LambdaFunctionArn": "arn:aws:lambda:us-east-1:000000000000:function:s3-to-sqs-logger",
                "Events": ["s3:ObjectCreated:*"]
            }
        ]
    }'
```{{exec}}

---

### 4. Test the Integration
Upload a new file and see the chain reaction!

1. **Upload to S3:**
`echo "Secret Message" > alert.txt`{{exec}}
`awslocal s3 cp alert.txt s3://integration-bucket/alert.txt`{{exec}}

2. **Check SQS for the notification:**
`awslocal sqs receive-message --queue-url http://localhost:4566/000000000000/lambda-alerts`{{exec}}