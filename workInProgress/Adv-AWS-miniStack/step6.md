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

```bash
awslocal lambda create-function \
    --function-name S3Processor \
    --runtime python3.9 \
    --handler lambda_function.lambda_handler \
    --role arn:aws:iam::000000000000:role/LambdaExecRole \
    --zip-file fileb://function.zip
```{{exec}}

---

### 3. Invoke and Verify

Trigger the function. We'll capture the output in `output.json`.

`awslocal lambda invoke --function-name S3Processor output.json`{{exec}}

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
