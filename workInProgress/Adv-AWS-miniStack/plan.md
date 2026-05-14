# Completion Plan: Advanced AWS on MiniStack

This plan outlines the steps required to complete the `Adv-AWS-miniStack` lab, transitioning from basic setup to a complex cross-account S3 processing scenario.

## Scenario Recap
A Lambda function in one context (Account B) assumes an IAM Role in another context (Account A) using **STS** to read a private file from an **S3** bucket.

---

## Step-by-Step Implementation

### Phase 0: Asset & Environment Alignment
- **Observation**: Current `main.tf` and `index.json` reference Kubernetes/Helm, while `intro.md` focuses on AWS MiniStack.
- **Action**: 
    - Update `index.json` to use a standard `ubuntu` or `ubuntu-4GB` image if Kubernetes is not strictly required.
    - Replace the Kubernetes-focused Terraform files with AWS-focused ones (e.g., provisioning IAM roles/S3 via Terraform if desired, though CLI is easier for learning).
    - Align `assets` in `index.json` with the files needed for the S3/Lambda scenario.

### Step 1: Initial Setup (Completed)
- Start MiniStack via Docker Compose.
- Install and configure AWS CLI.
- Create the `awslocal` alias.
- Verify connectivity.

### Step 2: IAM Foundations & Identity
- **Goal**: Establish the base identity.
- **Actions**:
    - Clean up the current `step2.md` to focus on IAM Users and Groups.
    - Create `DevUser`.
    - Explore `sts get-caller-identity` and `configure list`.
    - Introduce the concept of ARNs in MiniStack.

### Step 3: The Cross-Account "Handshake" (STS)
- **Goal**: Master Role Assumption.
- **Actions**:
    - Create `DevRole` with a **Trust Policy** allowing `DevUser`.
    - Create a **User Policy** for `DevUser` allowing `sts:AssumeRole` on `DevRole`.
    - Verify role assumption via CLI to get temporary credentials.

### Step 4: S3 & Resource-Based Policies
- **Goal**: Secure data storage.
- **Actions**:
    - Create the `production-data-payloads` bucket.
    - Create an **S3 Bucket Policy** that explicitly allows `DevRole` to `s3:GetObject`.
    - Upload a sample `daily_report.json`.

### Step 5: Lambda Development
- **Goal**: Prepare the compute layer.
- **Actions**:
    - Provide the Python blueprint using `boto3`.
    - Instructions for zipping the function.
    - Explain the importance of `AWS_ENDPOINT_URL` for local execution.

### Step 6: Deployment & Integration Test
- **Goal**: The "End-to-End" run.
- **Actions**:
    - Create a Lambda Execution Role.
    - Deploy the Lambda function using `awslocal lambda create-function`.
    - Invoke the function.
    - Verify the output: "Successfully read object data using STS tokens!".

### Step 7: Governance (Tagging & SCPs)
- **Goal**: Enterprise-grade management.
- **Actions**:
    - Implement the FinOps tagging standards.
    - Use `resourcegroupstaggingapi` to audit resources.
    - (Optional/Advanced) Demonstrate a Service Control Policy (SCP) to enforce tagging.

---

## Technical Assets Needed
- `lambda_function.py`: The core logic.
- `trust-policy.json`: For the IAM Role.
- `bucket-policy.json`: For S3.
- `setup-all.sh`: (Optional) A background script to pre-provision some resources if the user wants to skip ahead.

## Validation Strategy
- Each step must have a verification command (e.g., `awslocal sts get-caller-identity`).
- The final step must show the Lambda logs as proof of success.
