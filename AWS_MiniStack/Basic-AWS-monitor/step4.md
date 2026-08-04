# Auditing (CloudTrail)

In this step, we will audit API activity to maintain security posture.

## 1. Look up recent events
Record of API calls made to your account.

```bash
awslocal cloudtrail lookup-events --max-items 5
```{{exec}}

## 2. Filter for specific actions
Filter by event name (e.g., CreateQueue).

```bash
awslocal cloudtrail lookup-events \
    --lookup-attributes AttributeKey=EventName,AttributeValue=CreateQueue
```{{exec}}

---
When running **LocalStack** locally, you *do* have access to CloudTrail functionality, though its depth depends on whether you are using LocalStack's Community (free) or Pro/Enterprise editions.

---

### CloudTrail Functionality in LocalStack

LocalStack supports standard CloudTrail API actions (such as `CreateTrail`, `DescribeTrails`, `StartLogging`, etc.).

* **Management Events:** In a real AWS environment, CloudTrail automatically records control-plane actions (management events). In LocalStack, calling supported local AWS services via the AWS CLI or SDK will naturally generate activity that can be tracked by a configured trail.
* **Storage:** You can configure a local Amazon S3 bucket within LocalStack to receive your CloudTrail log files.

---

### How to Put Something into a CloudTrail Log

CloudTrail is designed exclusively to track **AWS API calls and resource management activities** rather than arbitrary application data. Therefore, you cannot directly inject a custom text message or custom log entry into CloudTrail via a generic "put log" command (unlike CloudWatch Logs, which uses `PutLogEvents`).

Instead, to get an entry into your local CloudTrail logs, you must **perform a supported AWS API action** against LocalStack. LocalStack will then capture that action and record it to your trail.

#### Step-by-Step Example

You can set up a trail and trigger a logged event using the LocalStack wrapper (`awslocal`) in your terminal:

1. **Create an S3 bucket to hold the logs:**
```bash
awslocal s3 mb s3://my-cloudtrail-bucket
```{{exec}}


2. **Create the CloudTrail trail:**
```bash
awslocal cloudtrail create-trail --name local-trail --s3-bucket-name my-cloudtrail-bucket
```{{exec}}


3. **Start logging:**
```bash
awslocal cloudtrail start-logging --name local-trail
```{{exec}}


4. **Trigger an AWS API call to generate a log entry:**
Any action you take against LocalStack's emulated services will now be recorded. For example, creating a new S3 bucket:
```bash
awslocal s3 mb s3://my-test-app-bucket
```{{exec}}


5. **Verify the log file:**
LocalStack will record this `CreateBucket` API call and deliver the log file to your local S3 bucket (`my-cloudtrail-bucket`). You can list or read the contents of that bucket to view the generated CloudTrail JSON log:
```bash
awslocal s3 ls s3://my-cloudtrail-bucket --recursive
```{{exec}}

6. **Describe**
```bash
awslocal cloudtrail list-trails
```{{exec}}

```bash
awslocal cloudtrail describe-trails
```{{exec}}

```bash
awslocal cloudtrail get-trail --name local-trail
```{{exec}}
