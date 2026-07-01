# Messaging (SQS & SNS)

Messaging services allow different parts of your application to communicate asynchronously.

## 1. SQS
```bash
awslocal sqs create-queue --queue-name AppQueue
awslocal sqs send-message --queue-url http://localhost:4566/000000000000/AppQueue --message-body "Hello from SQS"
```{{exec}}

## 2. SNS
```bash
awslocal sns create-topic --name MyTopic
awslocal sns subscribe \
    --topic-arn arn:aws:sns:us-east-1:000000000000:MyTopic \
    --protocol sqs \
    --notification-endpoint arn:aws:sqs:us-east-1:000000000000:MyQueue
```{{exec}}
