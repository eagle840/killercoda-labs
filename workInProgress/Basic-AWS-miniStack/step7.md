# Monitor

## CloudWatch


## CloudTrail


In **MiniStack**, accessing logs for CloudWatch and CloudTrail works similarly to how you'd handle them in a standard AWS CLI environment, but since it's a local emulator, everything is routed through your local endpoint.

Since you're working on the **AWS Infrastructure as Code Katacoda lab**, here is how you can interact with those logs using the CLI.

---

## 1. CloudWatch Logs

By default, MiniStack emulates the CloudWatch Logs service. To view logs (e.g., from a Lambda function or a custom log group), you use the `logs` subcommand.

### List Log Groups

First, verify your log groups are being created:

```bash
aws --endpoint-url=http://localhost:4566 logs describe-log-groups

```

### View Log Events

Once you have the `log-group-name`, you can fetch the actual entries. If you have a specific stream name:

```bash
aws --endpoint-url=http://localhost:4566 logs get-log-events \
    --log-group-name "/aws/lambda/my-function" \
    --log-stream-name "2026/05/15/[$LATEST]..."

```

---

## 2. CloudTrail Logs

In a local environment like MiniStack, CloudTrail is often used to audit the API calls you're making to the emulator itself.

### View Event History

The easiest way to see recent activity (the last 90 days of management events) is the `lookup-events` command:

```bash
aws --endpoint-url=http://localhost:4566 cloudtrail lookup-events

```

### Filtering Events

If the output is too noisy, you can filter by event name (e.g., to see only `CreateBucket` calls):

```bash
aws --endpoint-url=http://localhost:4566 cloudtrail lookup-events \
    --lookup-attributes AttributeKey=EventName,AttributeValue=CreateBucket

```

---

## Pro-Tips for your Lab

* **Tail Logs:** If you want to watch CloudWatch logs in real-time (similar to `tail -f`), use the `tail` command available in newer versions of the AWS CLI:
```bash
aws --endpoint-url=http://localhost:4566 logs tail /aws/lambda/my-function --follow

```


* **MiniStack Logs:** If the AWS services themselves aren't behaving, remember you can check the container logs for MiniStack to see how it's processing your requests:
```bash
docker logs <ministack-container-id>

```



Are you seeing specific errors in the lab when trying to provision the IAM roles for these services?

```

```


To find the **log-stream-names** within a specific log group in MiniStack, you use the `describe-log-streams` command.

Based on the CloudWatch hierarchy, a **Log Group** acts as a container, while the **Log Streams** are the actual sequences of log events (usually grouped by a specific instance of a resource, like a Lambda execution or a container ID).

---

### The Command

Run the following command, replacing `/aws/lambda/my-function` with the name of the group you saw in your previous output:

```bash
aws --endpoint-url=http://localhost:4566 logs describe-log-streams \
    --log-group-name "/aws/lambda/my-function"

```

### Filtering the Output

If you have many streams and only want the names, you can use the `--query` parameter to clean up the JSON response:

```bash
aws --endpoint-url=http://localhost:4566 logs describe-log-streams \
    --log-group-name "/aws/lambda/my-function" \
    --query 'logStreams[*].logStreamName' \
    --output text

```

### Useful Variations

* **Most Recent First:** To find the latest activity (useful for debugging the most recent lab execution), sort them by the last event time:
```bash
aws --endpoint-url=http://localhost:4566 logs describe-log-streams \
    --log-group-name "/aws/lambda/my-function" \
    --order-by LastEventTime \
    --descending

```


* **Limit Results:** If the lab has generated dozens of streams, you can limit the return to just the most recent one:

```bash
    aws --endpoint-url=http://localhost:4566 logs describe-log-streams \
        --log-group-name "/aws/lambda/my-function" \
        --limit 1
    ```



Once you have the `logStreamName`, you can plug it back into the `get-log-events` command we discussed earlier to see the actual error messages or print statements. 

Are the streams appearing as expected, or is the log group currently empty?

```


--- 

# FIX BROKEN

If the command is still returning a `ResourceNotFoundException` even with single quotes, it usually points to one of three "invisible" issues common when working with local emulators like MiniStack.

### 1. The "Hidden Space" or Typo

Sometimes when copy-pasting from a terminal, a trailing space or a hidden character gets included in the stream name.

* **Verification:** Run the `describe-log-streams` command again and look *extremely* closely at the name.
* **The Fix:** Try using the `--log-stream-name` without typing it. Let the CLI find it for you:
```bash
# This stores the exact name in a variable to avoid any typing/quoting errors
LATEST_STREAM=$(aws --endpoint-url=http://localhost:4566 logs describe-log-streams --log-group-name "/aws/lambda/S3Processor" --query 'logStreams[0].logStreamName' --output text)

aws --endpoint-url=http://localhost:4566 logs get-log-events --log-group-name "/aws/lambda/S3Processor" --log-stream-name "$LATEST_STREAM"

```



### 2. Case Sensitivity & Forward Slashes

MiniStack (and AWS) are strictly case-sensitive.

* Check if `/aws/lambda/S3Processor` is exactly as it appears in `describe-log-groups`. If the "S" or "P" are different cases, it will throw a `ResourceNotFoundException`.
* Ensure there isn't a leading or trailing slash in the log group name that you might be missing or adding unnecessarily.

### 3. Log Expiration or MiniStack Reset

If you are using MiniStack in a Katacoda environment, the "persistence" can be volatile.

* If the MiniStack container restarted or the lab timed out briefly, the metadata (the list of streams) might still be cached in your terminal history, but the actual log data inside the emulator might have been wiped.
* **Test:** Trigger your Lambda again to generate a **brand new** stream, then try to list the streams again.

---

### The "Tail" Alternative (Highly Recommended)

Since `get-log-events` requires the specific stream name (which is tedious), try using the `tail` command. It ignores the stream names and just pulls everything from the **Log Group** as it happens:

```bash
aws --endpoint-url=http://localhost:4566 logs tail "/aws/lambda/S3Processor"

```

*If you add `--follow`, it will stay open and print logs the moment your S3 trigger hits the Lambda.*

**One last thing to check:** Are you sure the endpoint is still active? Run `curl http://localhost:4566/health` to make sure the `logs` service shows as "running" or "initialized."

```

```


# Gemini Full labstep:

### Lab Step: Monitoring with CloudWatch and CloudTrail

In this step, you will learn how to monitor your local cloud infrastructure by inspecting logs and auditing API activity within the MiniStack environment.

---

### 1. View CloudWatch Logs

When your resources (like Lambda functions) execute, they send output to **CloudWatch Logs**. These are organized into **Log Groups** (the service) and **Log Streams** (the specific execution instance).

**A. List all available Log Groups:**

```bash
aws --endpoint-url=http://localhost:4566 logs describe-log-groups

```

**B. Find the Log Streams for your S3Processor:**

```bash
aws --endpoint-url=http://localhost:4566 logs describe-log-streams \
    --log-group-name "/aws/lambda/S3Processor" \
    --query 'logStreams[*].logStreamName' \
    --output text

```

**C. Retrieve the Log Events:**
Because stream names contain special characters like `[$LATEST]`, you must wrap the name in **single quotes** to prevent shell errors. Replace `<stream_name>` with the output from the previous command:

```bash
aws --endpoint-url=http://localhost:4566 logs get-log-events \
    --log-group-name "/aws/lambda/S3Processor" \
    --log-stream-name '<stream_name>'

```

> **Pro-Tip:** Use the `tail` command to bypass stream names and watch logs in real-time:
> `aws --endpoint-url=http://localhost:4566 logs tail "/aws/lambda/S3Processor" --follow`

---

### 2. Audit Activity with CloudTrail

CloudTrail records every API call made to MiniStack. This is vital for debugging IAM permission issues or verifying that an IaC script actually triggered a resource creation.

**A. Look up recent management events:**

```bash
aws --endpoint-url=http://localhost:4566 cloudtrail lookup-events

```

**B. Filter for specific actions (e.g., S3 Bucket creation):**

```bash
aws --endpoint-url=http://localhost:4566 cloudtrail lookup-events \
    --lookup-attributes AttributeKey=EventName,AttributeValue=CreateBucket

```

---

### Summary Checklist

* [ ] Verified Log Groups exist.
* [ ] Successfully escaped `[$LATEST]` using single quotes.
* [ ] Observed API call history via CloudTrail.

---

### Troubleshooting Note

If you receive a `ResourceNotFoundException` despite the stream appearing in the list:

1. **Check for typos:** Ensure the Log Group name case matches exactly (e.g., `S3Processor` vs `s3processor`).
2. **Check Persistence:** If the MiniStack container restarted, previous logs may have been cleared from memory.
3. **Check Health:** Run `curl http://localhost:4566/health` to ensure the `logs` and `cloudtrail` services are `running`.