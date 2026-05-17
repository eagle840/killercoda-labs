# Messaging (SQS & SNS)

Messaging services allow different parts of your application to communicate asynchronously.

### 1. SQS (Simple Queue Service)

SQS is a "Pull" based messaging service.

Create a queue:

`awslocal sqs create-queue --queue-name MyQueue`{{exec}}

Send a message to the queue:

`awslocal sqs send-message --queue-url http://localhost:4566/000000000000/MyQueue --message-body "Hello from SQS"`{{exec}}

Receive the message:

`awslocal sqs receive-message --queue-url http://localhost:4566/000000000000/MyQueue`{{exec}}

---

### 2. SNS (Simple Notification Service)

SNS is a "Push" based messaging service (Pub/Sub).

Create a topic:

`awslocal sns create-topic --name MyTopic`{{exec}}

Subscribe an SQS queue to the topic (Fan-out pattern):

```bash
awslocal sns subscribe \
    --topic-arn arn:aws:sns:us-east-1:000000000000:MyTopic \
    --protocol sqs \
    --notification-endpoint arn:aws:sqs:us-east-1:000000000000:MyQueue
```{{exec}}

Publish a message to the topic:

```bash
awslocal sns publish \
    --topic-arn arn:aws:sns:us-east-1:000000000000:MyTopic \
    --message "Broadcast message via SNS"
```{{exec}}

Verify the message arrived in SQS:

`awslocal sqs receive-message --queue-url http://localhost:4566/000000000000/MyQueue`{{exec}}

---

### 3. EventBridge

EventBridge is an "Event Bus" for connecting applications.

List event buses:

`awslocal events list-event-buses`{{exec}}

### Summary
You've used **Queues** (SQS) and **Topics** (SNS) to decouple your application components. In the final step, we'll learn how to **Monitor** all these resources.
