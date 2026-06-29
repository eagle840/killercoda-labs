# Governance & Policies

In this step, we will use Service Control Policies (SCPs) to set organizational guardrails.

## 1. Create SCP
Create an SCP that denies S3 bucket creation if a project tag is missing.
```bash
cat <<EOF > enforce-tagging-scp.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyS3WithoutProjectTag",
      "Effect": "Deny",
      "Action": "s3:CreateBucket",
      "Resource": "*",
      "Condition": {
        "Null": { "aws:RequestTag/Project": "true" }
      }
    }
  ]
}
EOF
```{{exec}}

## 2. Deploy SCP
Create the policy in the organization.
```bash
awslocal organizations create-policy \
    --content file://enforce-tagging-scp.json \
    --description "Enforces Project tag on S3 creation" \
    --name "EnforceProjectTag" \
    --type SERVICE_CONTROL_POLICY
```{{exec}}
