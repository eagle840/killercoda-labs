# S3 & Resource-Based Policies

Now that we have our identities (`DevUser` and `DevRole`) and our handshake mechanism (`STS`), we need some data to protect.

In AWS, S3 is a "Resource-Based" service. This means you can attach a policy directly to the **Bucket** itself to control who can look inside.

### 1. Create the Production Bucket

Let's create the bucket that our Lambda will eventually process.

`awslocal s3 mb s3://production-data-payloads`{{exec}}

---

### 2. Upload Sample Data

Create a dummy log file and upload it to the bucket.

```bash
cat <<EOF > daily_report.json
{
  "timestamp": "2026-05-14T10:00:00Z",
  "status": "active",
  "records": 1500,
  "summary": "LocalStack S3 simulation successful"
}
EOF
```{{exec}}

`awslocal s3 cp daily_report.json s3://production-data-payloads/logs/daily_report.json`{{exec}}

---

### 3. Lockdown: The Bucket Policy

By default, this bucket is only accessible by the account that created it. To allow our **DevRole** (which represents our "Worker") to read this file, we must add a **Bucket Policy**.

```bash
cat <<EOF > bucket-policy.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::000000000000:role/DevRole"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::production-data-payloads/*"
        }
    ]
}
EOF
```{{exec}}

Apply the policy to the bucket:

`awslocal s3api put-bucket-policy --bucket production-data-payloads --policy file://bucket-policy.json`{{exec}}

---

### 4. Verify the Policy

You can check the policy currently applied to the bucket with this command:

`awslocal s3api get-bucket-policy --bucket production-data-payloads --output json | jq -r .Policy | jq .`{{exec}}

### Summary
*   **Identity-Based Policy**: Attached to a User/Role (Step 2).
*   **Resource-Based Policy**: Attached to the Bucket (Step 4).

In the next step, we will write the **Lambda function** that will use these policies to perform its cross-account processing magic!
