# The Cross-Account "Handshake" (STS)

In the previous step, you created a User. In this step, we introduce **IAM Roles** and the **Security Token Service (STS)**. 

A Role is an identity that doesn't have its own credentials (like a password or access keys). Instead, it is "assumed" by someone else.

### 1. Create the Role with a "Trust Policy"

For a User to assume a Role, the Role must explicitly trust them. This is called a **Trust Policy**.

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
```{{exec}}

Now, create the role in MiniStack:

`awslocal iam create-role --role-name DevRole --assume-role-policy-document file://trust-policy.json`{{exec}}

---

### 2. Grant the User Permission to "Assume"

Even if the Role trusts the User, the User still needs permission to perform the action. 

```bash
cat <<EOF > user-assume-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::000000000000:role/DevRole"
    }
  ]
}
EOF
```{{exec}}

Attach this permission to `DevUser`:

```bash
awslocal iam put-user-policy \
  --user-name DevUser \
  --policy-name AllowAssumeDevRole \
  --policy-document file://user-assume-policy.json
```{{exec}}

---

### 3. Performing the Handshake (AssumeRole)

Now we use **STS** to request temporary credentials. This command "switches" your identity.

```bash
awslocal sts assume-role \
  --role-arn arn:aws:iam::000000000000:role/DevRole \
  --role-session-name "LabSession1"
```{{exec}}

### What just happened?
Look at the output. STS returned an **AccessKeyId**, **SecretAccessKey**, and a **SessionToken**. 

If you were to export these values into your environment variables, any command you run would be executed as **DevRole**, not **DevUser**.

### Summary
*   **Trust Policy**: The Role's "Guest List" (Who can enter).
*   **User Policy**: The User's "Key" (Permission to request entry).
*   **STS**: The "Security Guard" who validates the handshake and hands out temporary badges.

In the next step, we'll create an **S3 Bucket** and see how to give `DevRole` permission to access it.
