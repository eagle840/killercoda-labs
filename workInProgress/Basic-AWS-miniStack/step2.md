# IAM & Security Governance

In this step, you will master the foundational security layer of AWS. In MiniStack, IAM serves the same purpose as it does in production: defining **who** (Users/Roles) can do **what** (Policies) on **which** resources.

## 1. Verify Your Identity

Before creating new identities, let's see who the CLI is currently acting as. 

```bash
awslocal sts get-caller-identity
```{{exec}}

*Note: In MiniStack, the Account ID is typically `000000000000`.*

Check your active configuration source:
```bash
awslocal configure list
```{{exec}}

---

## 2. Create a User and Apply Permissions

A User represents a person or service. By default, a new user has **zero** permissions.

### A. Create the "DevUser"
```bash
awslocal iam create-user --user-name DevUser
```{{exec}}

### B. Define a Scoped Policy
We want `DevUser` to only have Read-Only access to S3. Create a local policy file:

```bash
cat <<EOF > s3-readonly.json
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

### C. Create and Attach the Policy
1. Create the policy resource in MiniStack:
```bash
awslocal iam create-policy \
    --policy-name S3ReadOnly \
    --policy-document file://s3-readonly.json
```{{exec}}

2. Attach it to your user:
```bash
awslocal iam attach-user-policy \
    --user-name DevUser \
    --policy-arn arn:aws:iam::000000000000:policy/S3ReadOnly
```{{exec}}

---

## 3. The Security Handshake: IAM Roles

Roles allow identities to "switch" contexts temporarily. This is safer than sharing keys. To get `DevUser` to assume a role, you must complete a handshake between the **User** and the **Role**.

### Step 1: Create the Role with a "Trust Policy"
The Role needs a policy that says: *"I trust DevUser to wear me."*

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

Create the role:
```bash
awslocal iam create-role \
  --role-name "DevRole" \
  --assume-role-policy-document file://trust-policy.json
```{{exec}}

### Step 2: Grant the User Permission to "Assume"
Now the User needs permission to request the Role's keys.

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

Attach the inline policy to the user:
```bash
awslocal iam put-user-policy \
  --user-name DevUser \
  --policy-name AllowAssumeDevRole \
  --policy-document file://user-assume-policy.json
```{{exec}}

### Step 3: Assume the Role
Now perform the actual switch to get temporary credentials.
```bash
awslocal sts assume-role \
  --role-arn arn:aws:iam::000000000000:role/DevRole \
  --role-session-name "LabSession"
```{{exec}}

---

## 4. Resource Tagging & Governance

Tagging is metadata used for cost allocation (FinOps) and automation. Following industry standards (like the FinOps Foundation) ensures your environment remains manageable.

### A. Apply Standard Tags
Apply "Technical" and "Business" tags to your new user:

```bash
awslocal iam tag-user --user-name DevUser \
    --tags '{"Key": "Environment", "Value": "Dev"}' \
           '{"Key": "Project", "Value": "AWS-Lab"}' \
           '{"Key": "Owner", "Value": "PlatformTeam"}'
```{{exec}}

### B. Audit Your Resources
Use the **Resource Groups Tagging API** to find resources with specific metadata. This is the "Swiss Army Knife" for auditing across services.

List all resources tagged with `Environment=Dev`:
```bash
awslocal resourcegroupstaggingapi get-resources \
    --tag-filters Key=Environment,Values=Dev
```{{exec}}

### C. Discovery: Get all Tag Keys
Useful for finding "shadow" tags or inconsistent naming (e.g., `env` vs `Environment`).
```bash
awslocal resourcegroupstaggingapi get-tag-keys
```{{exec}}

---

### Summary Checklist
* [ ] Verified identity via `sts`.
* [ ] Created `DevUser` with an S3 Read-Only managed policy.
* [ ] Configured a cross-identity "handshake" via IAM Roles.
* [ ] Applied industry-standard tags for FinOps compliance.
