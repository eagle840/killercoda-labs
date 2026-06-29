# Serverless Compute (Lambda)

In this step, we will create a Lambda function that processes events.

## 1. Create SQS Queue
```bash
awslocal sqs create-queue --queue-name lambda-alerts
```{{exec}}

## 2. Deploy Lambda
We will deploy a simple Python function to process events.
```bash
awslocal cloudformation deploy \
    --template-file integration-template.yml \
    --stack-name integration-stack \
    --capabilities CAPABILITY_IAM
```{{exec}}
