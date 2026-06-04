# Simulating the Event Pipeline

Now for the "Aha!" moment. We will fire a test event and watch it flow through the infrastructure you just built with CloudFormation.

### 1. Fire a Test Payload
Simulate an application event by publishing a matching payload directly to the local EventBridge bus. We'll use the `my.local.app` source we defined in our CloudFormation rule.

```bash
awslocal events put-events --entries '[{
  "Source": "my.local.app", 
  "DetailType": "UserSignUp", 
  "Detail": "{\"user\": \"alice\", \"action\": \"signup\"}"
}]'
```{{exec}}

### 2. Verify Delivery: SQS Queue
Our EventBridge rule was configured to send events to the SQS queue. Let's see if the message arrived.

First, get your Queue URL from the stack outputs:
```bash
QUEUE_URL=$(awslocal cloudformation describe-stacks \
  --stack-name local-core-infra \
  --query "Stacks[0].Outputs[?OutputKey=='QueueURL'].OutputValue" \
  --output text)
```{{exec}}

Now, receive the message:
```bash
awslocal sqs receive-message --queue-url $QUEUE_URL
```{{exec}}

### 3. Verify Delivery: CloudWatch Logs
We also targeted a Log Group. Let's check the logs to see if EventBridge recorded the activity.

First, identify the log stream (it's created automatically when the first event arrives):
```bash
LOG_STREAM=$(awslocal logs describe-log-streams \
  --log-group-name /aws/events/local-lab-logs-dev \
  --query "logStreams[0].logStreamName" \
  --output text)
```{{exec}}

Now, view the log events:
```bash
awslocal logs get-log-events \
  --log-group-name /aws/events/local-lab-logs-dev \
  --log-stream-name $LOG_STREAM
```{{exec}}

### 4. Summary of the Flow
1. **Source:** You sent an event via `put-events`.
2. **Router:** EventBridge matched the `source: "my.local.app"` pattern.
3. **Targets:** The rule copied the event to **both** the SQS queue and the Log Group.

This is the power of CloudFormation: you defined these connections in code once, and AWS (emulated by MiniStack) handles the heavy lifting of message routing for you.
