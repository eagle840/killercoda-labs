# Wiring Resources & Stack Outputs

In this step, you'll learn how to connect resources together (Wiring) and how to expose important information (Outputs) so other systems or users can find your resources.

### 1. Add an SNS Topic and Subscription
We'll add an SNS Topic and wire our existing SQS Queue to it. This creates a "Fan-out" pattern where messages sent to the topic are automatically delivered to the queue.

Update the `Resources` section of your `infrastructure.yaml` by adding these two blocks:

```yaml
  # 3. The Notification Topic
  LocalNotificationTopic:
    Type: AWS::SNS::Topic
    Properties:
      TopicName: !Sub 'local-lab-topic-${EnvironmentType}'

  # 4. Connecting SNS to SQS (The Wiring)
  QueueSubscription:
    Type: AWS::SNS::Subscription
    Properties:
      TopicArn: !Ref LocalNotificationTopic
      Endpoint: !GetAtt LocalWorkQueue.Arn
      Protocol: sqs
```{{copy}}

### 2. Define Stack Outputs
Outputs act as the "return values" of your template. They are essential for finding the URLs and ARNs of the resources you just created.

Add an `Outputs` section at the very end of your `infrastructure.yaml` (outside the `Resources` block):

```yaml
Outputs:
  BucketDomainName:
    Value: !GetAtt LocalDataBucket.DomainName
  QueueURL:
    Value: !Ref LocalWorkQueue
  TopicArn:
    Value: !Ref LocalNotificationTopic
```{{copy}}

### 3. Update the Stack
Apply the new wiring and outputs to your local environment.

```bash
awslocal cloudformation update-stack \
  --stack-name local-core-infra \
  --template-body file://infrastructure.yaml \
  --parameters ParameterKey=EnvironmentType,ParameterValue=dev
```{{exec}}

### 4. Inspect the Outputs
Once the update is complete, you can retrieve the outputs using the CLI. This is much faster than hunting for resource names manually.

```bash
awslocal cloudformation describe-stacks \
  --stack-name local-core-infra \
  --query "Stacks[0].Outputs"
```{{exec}}

### 5. Verify the Wiring (Physical Check)
Confirm that the SNS Topic was created and has a subscription.

```bash
awslocal sns list-topics
awslocal sns list-subscriptions
```{{exec}}

> **Pro-Tip:** Notice how `!Ref` usually returns the primary ID (like a URL or ARN), while `!GetAtt` allows you to pick specific attributes (like `Arn` or `DomainName`).
