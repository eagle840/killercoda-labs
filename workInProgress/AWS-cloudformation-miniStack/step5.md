# Event-Driven Infrastructure: EventBridge & Logs

In this step, you'll build the "plumbing" for an event-driven architecture. You'll add an **EventBridge Rule** to catch specific events and a **CloudWatch Log Group** to record them.

### 1. Add Logging and Event Routing
We want our infrastructure to react whenever a specific event (like a `UserSignUp`) occurs in our application. 

Update the `Resources` section of your `infrastructure.yaml` by adding these two blocks:

```yaml
  # 5. The Log Group (For auditing events)
  LocalLogGroup:
    Type: AWS::Logs::LogGroup
    Properties:
      LogGroupName: !Sub '/aws/events/local-lab-logs-${EnvironmentType}'

  # 6. The EventBridge Rule (The "Traffic Controller")
  LocalEventRule:
    Type: AWS::Events::Rule
    Properties:
      Name: !Sub 'local-lab-rule-${EnvironmentType}'
      Description: "Routes custom app events to SQS and Logs"
      EventPattern:
        source:
          - "my.local.app"
      Targets:
        - Arn: !GetAtt LocalWorkQueue.Arn
          Id: "SQSTarget"
        - Arn: !GetAtt LocalLogGroup.Arn
          Id: "LogGroupTarget"
```{{copy}}

### 2. Update the Stack
Apply these architectural changes. CloudFormation will now wire up the event bus to your queue and log group automatically.

```bash
awslocal cloudformation update-stack \
  --stack-name local-core-infra \
  --template-body file://infrastructure.yaml \
  --parameters ParameterKey=EnvironmentType,ParameterValue=dev
```{{exec}}

### 3. Verify the Rule
Confirm that EventBridge has registered your new rule and that it has the correct targets.

```bash
awslocal events list-rules
```{{exec}}

To see the targets for your specific rule:
```bash
awslocal events list-targets-by-rule --rule local-lab-rule-dev
```{{exec}}

### 4. Verify the Log Group
Check that the Log Group was created and is ready to receive data.

```bash
awslocal logs describe-log-groups --log-group-name-prefix /aws/events/
```{{exec}}

---

### What just happened?
You've created a **decoupled architecture**. Your application (which we'll simulate in the next step) doesn't need to know that a Queue or a Log Group exists. It just sends an event to the "Bus," and CloudFormation's configuration ensures that the message lands in the right places.
