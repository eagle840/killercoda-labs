# Step 2: Python Environment Setup

Now that MiniStack is running and the AWS CLI is configured, let's set up the Python environment to work with `boto3` and `jupyterlab`.

### 1. Prepare Python Environment
We will use Python 3.12 and create a virtual environment to isolate our dependencies.

```bash
# Install Python 3.12 and venv
sudo apt install -y python3.12-venv
```{{exec}}

Now, create and activate the virtual environment:

```bash
# Create and activate the virtual environment
python3.12 -m venv venv
source venv/bin/activate
```{{exec}}

### 2. Install Dependencies
With the virtual environment active, install `boto3` and `jupyterlab`.

```bash
# Install boto3 and jupyterlab
pip install --upgrade pip
pip install boto3 jupyterlab
```{{exec}}

Once completed, you are ready to configure Jupyter Lab in the next step.

---
# Tagging

# Resource Tagging

In this step, we will learn how to apply and audit tags to enforce governance.

## 1. Apply Tags
Apply standard tags to a resource, such as a dummy user or bucket.

### Tagging an IAM User
```bash
awslocal iam tag-user --user-name DevUser \
    --tags '{"Key": "Environment", "Value": "Dev"}' \
           '{"Key": "Project", "Value": "AWS-Lab"}'
```{{exec}}

### Tagging an S3 Bucket
```bash
awslocal s3api put-bucket-tagging --bucket my-first-bucket --tagging 'TagSet=[{Key=Environment,Value=Test}]'
```{{exec}}

## 2. Audit Tags
Use the Resource Groups Tagging API to find resources with specific tags.

```bash
awslocal resourcegroupstaggingapi get-resources \
    --tag-filters Key=Environment,Values=Dev
```{{exec}}

## 3. Using Resource Groups Tagging API
You can use the Resource Groups Tagging API to tag resources directly and query their current tags.

### Tag a resource
```bash
awslocal resourcegroupstaggingapi tag-resources \
    --resource-arn-list arn:aws:s3:::my-first-bucket \
    --tags Environment=Production,Owner=DevTeam
```{{exec}}

### Query tags for a resource
```bash
awslocal resourcegroupstaggingapi get-resources \
    --resource-arn-list arn:aws:s3:::my-first-bucket
```{{exec}}

