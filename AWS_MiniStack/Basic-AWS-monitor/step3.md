# Observability (CloudWatch)

In this step, we will learn how to observe system activity.

## 1. List Log Groups
View available log groups for services.

```bash
awslocal logs describe-log-groups
```{{exec}}

## 2. Create a Logging Lambda
We will create a Lambda function that writes logs to CloudWatch.

```bash
cat <<EOF > lambda_function.py
import logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    logger.info("Hello from Lambda! Logging to CloudWatch.")
    return {"status": "success"}
EOF
```{{exec}}

```bash
zip function.zip lambda_function.py
```{{exec}}

```bash
awslocal lambda create-function \
    --function-name my-logging-lambda \
    --runtime python3.9 \
    --zip-file fileb://function.zip \
    --handler lambda_function.lambda_handler \
    --role arn:aws:iam::000000000000:role/service-role/dummy
```{{exec}}

## 3. Trigger the Lambda Periodically
We will trigger this function every 5 seconds in the background.

```bash
while true; do awslocal lambda invoke --function-name my-logging-lambda /dev/null; sleep 5; done &
```{{exec}}

## 4. Tail Logs
View log events in real-time to see the Lambda logs appearing.

```bash
awslocal logs tail "/aws/lambda/my-logging-lambda"
```{{exec}}

Lets clean up the output a little

```bash
awslocal logs tail "/aws/lambda/my-logging-lambda" --format short
```{{exec}}
