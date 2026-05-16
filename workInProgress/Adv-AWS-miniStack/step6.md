# Deployment & Integration Test

This is the moment of truth. We will deploy the zip file we created and execute the code.

### 1. Create a Lambda Execution Role

Even the Lambda service itself needs a Role to "exist" and run. This is different from the `DevRole` we assume inside the code.

```bash
cat <<EOF > lambda-exec-trust.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "lambda.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
```{{exec}}

`awslocal iam create-role --role-name LambdaExecRole --assume-role-policy-document file://lambda-exec-trust.json`{{exec}}

---

### 2. Deploy the Function

Now, upload the `function.zip` to the MiniStack Lambda service.


WIP the handler value should be <filename>.<functionName>


```bash
awslocal lambda create-function \
    --function-name S3Processor \
    --runtime python3.9 \
    --handler lambda_function.lambda_handler \
    --role arn:aws:iam::000000000000:role/LambdaExecRole \
    --zip-file fileb://function.zip
```{{exec}}

If you need to reupload the zip:

```bash
aws lambda update-function-code  \
  --function-name S3Processor   \
  --zip-file fileb://function.zip    \
  --endpoint-url http://localhost:4566
```{{exec}}

---

### 3. Invoke and Verify

Trigger the function. We'll capture the output in `output.json`.

`awslocal lambda invoke --function-name S3Processor output.json`{{exec}}

`awslocal --endpoint-url=http://localhost:4566 lambda invoke --function-name S3Processor output.json`{{exec}}

Now, inspect the result:

`cat output.json | jq`{{exec}}

### Expected Output
If everything is configured correctly, you should see:
```json
{
  "statusCode": 200,
  "body": "{\"message\": \"File processed\", \"content\": { ... }}"
}
```

### What happened behind the scenes?
1. The Lambda started as `LambdaExecRole`.
2. It called **STS** to become `DevRole`.
3. It used those new keys to bypass the **S3 Bucket Policy**.
4. It read the file and returned the content to you.

### Summary
You have successfully built a **Multi-Service Security Chain**. This is how enterprise-grade automation is built in AWS to maintain the principle of least privilege.

In the final step, we'll look at how to manage these resources at scale using **Tagging** and **SCPs**.

--- WIP troubleshooting a lambda function

Using MiniStack for a "Hello World" Lambda is a great way to verify your local environment without touching your Azure or AWS spend. Since you are likely running MiniStack on **localhost:4566**, we will use the AWS CLI with the `--endpoint-url` override.

### 1. Create the Lambda Function Code

Create a file named `index.py`:

```python
import json

def handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from MiniStack!')
    }

```

### 2. Package and Deploy

Lambda requires a `.zip` file. Run these commands in your terminal:

```bash
# 1. Zip the file
zip function.zip index.py

# 2. Create a dummy IAM role (MiniStack doesn't strictly enforce this, but CLI requires it)
aws --endpoint-url=http://localhost:4566 iam create-role \
    --role-name lambda-ex \
    --assume-role-policy-document '{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'

# 3. Create the function
aws --endpoint-url=http://localhost:4566 lambda create-function \
    --function-name hello-world \
    --runtime python3.9 \
    --handler index.handler \
    --zip-file fileb://function.zip \
    --role arn:aws:iam::000000000000:role/lambda-ex

```

### 3. Invoke the Function

Trigger the execution and check the output:

```bash
aws --endpoint-url=http://localhost:4566 lambda invoke \
    --function-name hello-world \
    response.json

# View the result
cat response.json

```

try `--debug`{{copy}}

---

## Troubleshooting Guide

If the steps above didn't result in a "Hello" message, check these common local emulation pitfalls:

### Phase: Deployment Failures

* **"Connection Refused":** MiniStack isn't running or is on a different port. Verify with `docker ps` or `curl http://localhost:4566/_ministack/health`.
* **"InvalidParameterValueException":** Usually means your `--handler` name doesn't match your filename or function name (e.g., if your file is `index.py` and function is `handler`, use `index.handler`).
* **"Runtime not supported":** Ensure you have the corresponding Docker image pulled if MiniStack is set to run Lambda in containers (the default behavior for many emulators).

### Phase: Invocation Failures

* **Function "Pending":** On the first run, MiniStack might be pulling the Lambda runtime Docker image (e.g., `public.ecr.aws/lambda/python:3.9`). Give it a minute.
* **Docker Socket Error:** If MiniStack is running inside Docker, it needs access to the host's Docker socket to spawn Lambda containers. Ensure you started it with:
`-v /var/run/docker.sock:/var/run/docker.sock`
* **Timeout:** If the invocation hangs, check the MiniStack logs. It’s often a networking issue where the Lambda container cannot reach the MiniStack "host" to report back.

### Phase: Permission/Credential Issues

* **CLI 403 Forbidden:** Even though it's local, the AWS CLI needs *some* credentials. Run `aws configure` and enter `test` for both Access Key and Secret Key if you haven't already.

How are you finding the transition from Azure's Function Apps to AWS Lambda so far?
