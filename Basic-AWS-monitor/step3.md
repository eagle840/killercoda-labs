# Observability (CloudWatch)

In this step, we will learn how to observe system activity.

## 1. List Log Groups
View available log groups for services.

```bash
awslocal logs describe-log-groups
```{{exec}}

## 2. Tail Logs
View log events in real-time.

```bash
awslocal logs tail "/aws/lambda/s3-to-sqs-logger"
```{{exec}}
