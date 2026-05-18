# Monitoring & Governance

In this final step, you will learn how to audit your cloud activity and inspect service logs using **CloudWatch** and **CloudTrail**.

---

### 1. CloudWatch Logs (Observability)

When your Lambda functions execute, they automatically send their output to CloudWatch. These are organized into **Log Groups** and **Log Streams**.

**A. List available Log Groups**
Find the group created for your Lambda in Step 5.
```bash
awslocal logs describe-log-groups
```{{exec}}

**B. Watch Logs in Real-Time**
Instead of hunting for specific stream names, use the `tail` command to see events as they happen.
```bash
awslocal logs tail "/aws/lambda/s3-to-sqs-logger"
```{{exec}}

*Note: If you don't see logs, try invoking the function again from the CLI in your other tab.*

---

### 2. CloudTrail (Security & Auditing)

CloudTrail records every API call made to your account. This is vital for security auditing and troubleshooting configuration changes.

**A. Look up recent management events**
This shows you the history of the commands you've run in this lab (e.g., `CreateQueue`, `PutRule`).
```bash
awslocal cloudtrail lookup-events --max-items 5
```{{exec}}

**B. Filter for specific actions**
Let's see exactly when the SQS queue was created.
```bash
awslocal cloudtrail lookup-events \
    --lookup-attributes AttributeKey=EventName,AttributeValue=CreateQueue
```{{exec}}

---

### 3. Resource Health

You can check the overall health of the MiniStack services via its internal health endpoint.

```bash
curl -s http://localhost:4566/_ministack/health | jq
```{{exec}}

---

### Summary Checklist
* [ ] Viewed Lambda logs via CloudWatch.
* [ ] Audited API activity via CloudTrail.
* [ ] Verified service health.

**You have now completed all the technical steps! Click the 'Next' button to finish the lab.**
