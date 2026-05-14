Building a local pipeline to stitch **IAM, STS, Lambda, and S3** together is an excellent choice. Since MiniStack runs real containerized infrastructure with a tiny footprint, it’s the perfect playground for this without worrying about real AWS spend or breaking cloud security baselines.

The absolute best scenario to demonstrate all four interacting is a **cross-account or multi-tenant log ingestion/file processor worker**.

### The Scenario: Cross-Account S3 Object Processor

Imagine you have an infrastructure setup where an application dumps log data or files into a central storage bucket (Account A), and a processing Lambda function lives in a management tools space (Account B).

To do its job safely, the Lambda function must dynamically ask for permission to look inside that external bucket, process the file, and gracefully exit.

---

## How the Elements Interact

Here is how the four services form the operational chain:

1. **IAM (The Foundation):** You define a permanent IAM Role for the Lambda execution context. You also define a target cross-account IAM Role that has explicit read access to the S3 bucket.
2. **Lambda (The Compute):** The function spins up natively in MiniStack using its own execution role permissions.
3. **STS (The Gateway):** Inside the Lambda code, you call STS (`assume_role`) to temporarily assume that target cross-account role. STS hands back a set of short-lived tokens.
4. **S3 (The Target):** The Lambda builds a new S3 client session using those temporary STS tokens and successfully downloads or manipulates the object from the restricted bucket.

---

## The Minimal Python Blueprint (`boto3`)

Since MiniStack maps all services natively to a single endpoint (typically `http://localhost:4566`), you can mock the multi-account behavior cleanly by setting up the explicit Trust Policies in IAM.

Here is what the core logic inside your local Lambda function would look like:

```python
import os
import boto3

# MiniStack default gateway endpoint
MINISTACK_ENDPOINT = os.getenv("AWS_ENDPOINT_URL", "http://localhost:4566")

def lambda_handler(event, context):
    target_role_arn = "arn:aws:iam::123456789012:role/CrossAccountS3Reader"
    bucket_name = "production-data-payloads"
    object_key = "logs/daily_report.json"
    
    # 1. Initialize the base STS client pointing to MiniStack
    sts_client = boto3.client(
        "sts", 
        endpoint_url=MINISTACK_ENDPOINT,
        region_name="us-east-1"
    )
    
    print(f"Requesting temporary credentials for: {target_role_arn}")
    
    # 2. Call STS to assume the target role
    assumed_role_object = sts_client.assume_role(
        RoleArn=target_role_arn,
        RoleSessionName="LambdaS3ProcessingSession",
        DurationSeconds=900 # 15 minutes minimum
    )
    
    # Extract the short-lived credentials block
    credentials = assumed_role_object["Credentials"]
    
    # 3. Create a scoped S3 client using the temporary STS tokens
    s3_client = boto3.client(
        "s3",
        endpoint_url=MINISTACK_ENDPOINT,
        region_name="us-east-1",
        aws_access_key_id=credentials["AccessKeyId"],
        aws_secret_access_key=credentials["SecretAccessKey"],
        aws_session_token=credentials["SessionToken"]
    )
    
    # 4. Interact with S3 using the assumed identity
    try:
        response = s3_client.get_object(Bucket=bucket_name, Key=object_key)
        data = response["Body"].read().decode("utf-8")
        print("Successfully read object data using STS tokens!")
        return {"statusCode": 200, "body": "Processing Complete"}
    except Exception as e:
        print(f"Access Denied or Error: {str(e)}")
        return {"statusCode": 500, "body": "Authorization Failure"}

```

---

## Key Things to Look For While Testing on MiniStack

* **Tenant Isolation Execution:** MiniStack allows you to emulate multi-tenancy by varying the 12-digit numeric structure in your `AWS_ACCESS_KEY_ID`. If you pass a 12-digit string as an access key in your local shell configuration, MiniStack uses that string as the explicit AWS Account ID for ARN generation. This is fantastic for validating that cross-account calls fail until the trust relationship is explicitly created.
* **The "Reset" Loop:** When building out your automation or testing script to create the IAM roles, bucket, and Lambda ZIP bundle, take advantage of MiniStack’s local lifecycle endpoint:
```bash
curl -X POST http://localhost:4566/_ministack/reset?init=1

```


This immediately wipes out the local memory state and runs your initialization hooks clean, meaning you can test your infrastructure setup script over and over again from bare metal in under two seconds.

Would you like to drill down into the AWS CLI shell commands or a lightweight Terraform manifest to provision the IAM trust documents and bucket boundaries required to run this locally?