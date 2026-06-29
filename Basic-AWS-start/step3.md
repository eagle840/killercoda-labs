# IAM Roles

In this step, we will implement secure, temporary credential delegation using IAM Roles.

## 1. Create a Role
Define a role that "trusts" our user.
```bash
cat <<EOF > trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "AWS": "arn:aws:iam::000000000000:user/DevUser" },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

awslocal iam create-role --role-name "DevRole" --assume-role-policy-document file://trust-policy.json
```{{exec}}

## 2. Assume the Role
Switch contexts to obtain temporary credentials.
```bash
awslocal sts assume-role \
  --role-arn arn:aws:iam::000000000000:role/DevRole \
  --role-session-name "LabSession"
```{{exec}}
