# Lambda Development

We have the **IAM Roles**, the **STS Handshake** configured, and the **S3 Bucket** with data. Now we need the **Compute** to tie it all together.

In this step, we'll write a Python Lambda function that assumes our `DevRole` to read the S3 object.

### 1. Create the Lambda Code

This script uses `boto3` to perform the 4-step chain: 
1. Connect to STS.
2. Assume the Role.
3. Extract temporary tokens.
4. Connect to S3 using those tokens.

```bash
cat <<EOF > lambda_function.py
import os
import boto3
import json

# Important: MiniStack services run on a single endpoint
MINISTACK_ENDPOINT = os.getenv("AWS_ENDPOINT_URL", "http://localhost:4566")

def lambda_handler(event, context):
    target_role_arn = "arn:aws:iam::000000000000:role/DevRole"
    bucket_name = "production-data-payloads"
    object_key = "logs/daily_report.json"
    
    print(f"Connecting to STS at {MINISTACK_ENDPOINT}...")
    sts_client = boto3.client("sts", endpoint_url=MINISTACK_ENDPOINT, region_name="us-east-1")
    
    # 1. Assume the Role
    print(f"Assuming role: {target_role_arn}")
    assumed_role = sts_client.assume_role(
        RoleArn=target_role_arn,
        RoleSessionName="LambdaS3Session"
    )
    
    # 2. Extract Credentials
    creds = assumed_role["Credentials"]
    
    # 3. Use Temporary Tokens for S3
    s3_client = boto3.client(
        "s3",
        endpoint_url=MINISTACK_ENDPOINT,
        region_name="us-east-1",
        aws_access_key_id=creds["AccessKeyId"],
        aws_secret_access_key=creds["SecretAccessKey"],
        aws_session_token=creds["SessionToken"]
    )
    
    try:
        response = s3_client.get_object(Bucket=bucket_name, Key=object_key)
        data = response["Body"].read().decode("utf-8")
        print("Success! Data retrieved using STS tokens.")
        return {
            "statusCode": 200,
            "body": json.dumps({"message": "File processed", "content": json.loads(data)})
        }
    except Exception as e:
        print(f"Error: {str(e)}")
        return {"statusCode": 500, "body": str(e)}
EOF
```{{exec}}

---

### 2. Package the Function

AWS Lambda requires your code to be zipped before deployment.

`apt install zip`{{exec}}

`zip function.zip lambda_function.py`{{exec}}

---

### 3. The "Local" Secret: `AWS_ENDPOINT_URL`

In a real AWS environment, `boto3` automatically finds the S3 and STS endpoints. In MiniStack, everything is at `http://localhost:4566`. 

Inside the code, we explicitly pass `endpoint_url=MINISTACK_ENDPOINT`. Without this, the Lambda function (which runs in its own container) would try to talk to the real AWS public cloud and fail.

### Summary
*   **boto3**: The AWS SDK for Python.
*   **assume_role**: The core STS method used to switch identities.
*   **Packaging**: Code must be zipped for the Lambda service to accept it.

In the next step, we will **Deploy** this function and see it in action!
