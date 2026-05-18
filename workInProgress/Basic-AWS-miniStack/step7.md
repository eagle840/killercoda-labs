# Messaging (SQS & SNS)

Messaging services allow different parts of your application to communicate asynchronously.

### 1. SQS (Simple Queue Service)

SQS is a "Pull" based messaging service. We already used a queue for our Lambda alerts, but let's create a dedicated one for generic app messages.

`awslocal sqs create-queue --queue-name AppQueue`{{exec}}

Send a message:
`awslocal sqs send-message --queue-url http://localhost:4566/000000000000/AppQueue --message-body "Hello from SQS"`{{exec}}

Receive the message:
`awslocal sqs receive-message --queue-url http://localhost:4566/000000000000/AppQueue`{{exec}}


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

### 3. EventBridge (Event-Driven Routing)

EventBridge is a serverless event bus that makes it easy to connect applications using data from your own apps, SaaS apps, and AWS services.

**A. Create an Event Rule**
Define a rule that "filters" for specific events. We'll look for events from `my.app` with an `OrderCreated` status.

```bash
awslocal events put-rule \
    --name MyOrderRule \
    --event-pattern '{"source": ["my.app"], "detail-type": ["OrderCreated"]}'
```{{exec}}

**B. Add a Target**
Tell EventBridge to send any matching events to your existing SQS queue.

```bash
awslocal events put-targets \
    --rule MyOrderRule \
    --targets "Id"="1","Arn"="arn:aws:sqs:us-east-1:000000000000:MyQueue"
```{{exec}}

**C. Fire a Test Event**
Send a custom event into the default bus. Note how we wrap the JSON `Detail` in a string.

```bash
awslocal events put-events --entries '[{
    "Source": "my.app",
    "DetailType": "OrderCreated",
    "Detail": "{\"orderId\": \"1234\", \"status\": \"new\"}"
}]'
```{{exec}}

**D. Verify in SQS**
Check the queue to see if EventBridge successfully routed your event.

```bash
awslocal sqs receive-message --queue-url http://localhost:4566/000000000000/MyQueue
```{{exec}}

---

### Summary
You've used **Queues** (SQS), **Topics** (SNS), and **Event Rules** (EventBridge) to decouple your application components. In the final step, we'll learn how to **Monitor** all these resources.
