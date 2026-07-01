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
