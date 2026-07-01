# Identity & Access Management

In this step, we will create IAM users and attach policies to control access.

## 1. Verify Identity
Check who the CLI is acting as.
```bash
awslocal sts get-caller-identity
```{{exec}}

## 2. Create User
Create a user named "DevUser".
```bash
awslocal iam create-user --user-name DevUser
```{{exec}}

## 3. Attach Policy
Attach a Read-Only S3 policy to the user.
```bash
# Create policy file
cat <<EOF > s3-readonly.json
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": ["s3:Get*", "s3:List*"],
        "Resource": "*"
    }]
}
EOF

# Create policy
awslocal iam create-policy --policy-name S3ReadOnly --policy-document file://s3-readonly.json

# Attach policy
awslocal iam attach-user-policy --user-name DevUser --policy-arn arn:aws:iam::000000000000:policy/S3ReadOnly
```{{exec}}
