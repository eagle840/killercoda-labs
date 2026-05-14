# IAM Foundations & Identity

In MiniStack, IAM (Identity and Access Management) is the gatekeeper. Even in a local environment, it validates who you are and what you can do.

### 1. Who am I right now?

Before creating new users, let's see what identity the AWS CLI is currently using. 

`awslocal sts get-caller-identity`{{exec}}

You'll notice the **Account ID** is `000000000000`. This is the default "Management Account" in MiniStack.

To see where these credentials are coming from (Environment Variables or Config files):

`awslocal configure list`{{exec}}

---

### 2. Creating your first Identity: DevUser

In AWS, you rarely use the "Root" or Management account for daily tasks. Let's create a specialized User for development.

`awslocal iam create-user --user-name DevUser`{{exec}}

Verify the user was created:

`awslocal iam list-users`{{exec}}

---

### 3. Granting Permissions (The Policy)

A User with no policies has **Zero Permissions**. Let's create a "ReadOnly" policy for S3 so `DevUser` can look at buckets but not delete them.

First, create the policy document:

```bash
cat <<EOF > s3-readonly-policy.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["s3:Get*", "s3:List*"],
            "Resource": "*"
        }
    ]
}
EOF
```{{exec}}

Now, create the policy in MiniStack:

`awslocal iam create-policy --policy-name S3ReadOnly --policy-document file://s3-readonly-policy.json`{{exec}}

---

### 4. Attaching the Policy

Finally, bind the policy to the user. This is what actually grants the permissions.

```bash
awslocal iam attach-user-policy \
    --user-name DevUser \
    --policy-arn arn:aws:iam::000000000000:policy/S3ReadOnly
```{{exec}}

Check the attached policies:

`awslocal iam list-attached-user-policies --user-name DevUser`{{exec}}

### Summary
You now have a **DevUser** with a managed **S3ReadOnly** policy. In the next step, we will dive into **STS** to see how this user can "assume" different roles to cross security boundaries.
