# Governance: Tagging & SCPs

Congratulations on building the security chain! In this final step, we move from **Engineering** to **Governance**. In large enterprises, you need to manage thousands of resources effectively.

### 1. FinOps Tagging Standards

Tags are metadata (Key-Value pairs). They are essential for cost allocation and automation. Let's tag our S3 bucket following industry best practices.

```bash
awslocal s3api put-bucket-tagging \
    --bucket production-data-payloads \
    --tagging 'TagSet=[{Key=CostCenter,Value=80432},{Key=Env,Value=Prod},{Key=Owner,Value=PlatformTeam}]'
```{{exec}}

Verify the tags:

`awslocal s3api get-bucket-tagging --bucket production-data-payloads`{{exec}}

---

### 2. Auditing with the Tagging API

AWS provides a specialized service (`resourcegroupstaggingapi`) to find and manage tags across **all** services (EC2, S3, Lambda, etc.) using one unified command.

Find all resources in our lab tagged as `Env=Prod`:

```bash
awslocal resourcegroupstaggingapi get-resources \
    --tag-filters Key=Env,Values=Prod \
    --query 'ResourceTagMappingList[*].ResourceARN'
```{{exec}}

---

### 3. Service Control Policies (SCPs)

While IAM controls what a User can do, **SCPs** (Service Control Policies) set the maximum permissions for an entire AWS Account.

For example, an SCP can **deny** the creation of any resource that doesn't have a `CostCenter` tag. This is the "Nuclear Option" for enforcement.

In MiniStack, you can simulate these organizational boundaries:

`awslocal organizations describe-organization`{{exec}}

### Final Lab Summary
Over these 7 steps, you have:
1.  **Bootstrapped** a local AWS environment with MiniStack.
2.  **Identified** the core IAM entities (`DevUser`).
3.  **Engineered** a secure cross-account handshake using **STS**.
4.  **Architected** resource-based security with **S3 Bucket Policies**.
5.  **Developed** a Python Lambda using the `boto3` SDK.
6.  **Deployed** and validated a functional security chain.
7.  **Governed** the resources using enterprise metadata standards.

### What's Next?
Check out the **finish.md** for more resources on MiniStack and Advanced AWS patterns!
