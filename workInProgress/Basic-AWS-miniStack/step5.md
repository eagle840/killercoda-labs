# Storage (S3, RDS, & DynamoDB)

AWS provides various storage types: Object (S3), Relational (RDS), and NoSQL (DynamoDB).

### 1. S3 (Object Storage)

Create a bucket to store your files. We will use this bucket later to trigger an automated workflow.

`awslocal s3 mb s3://integration-bucket`{{exec}}

Upload a test file:

`echo "Initial Data" > data.txt`{{exec}}

`awslocal s3 cp data.txt s3://integration-bucket/data.txt`{{exec}}

List bucket contents:

`awslocal s3 ls s3://lab-data-bucket/`{{exec}}

---

### 2. DynamoDB (NoSQL)

Create a simple Table for "Users":

```bash
awslocal dynamodb create-table \
    --table-name UsersTable \
    --attribute-definitions AttributeName=UserId,AttributeType=S \
    --key-schema AttributeName=UserId,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```{{exec}}

List tables:

`awslocal dynamodb list-tables`{{exec}}

---

### 3. RDS (Relational Database)

MiniStack emulates RDS by creating the metadata for a database instance.

```bash
awslocal rds create-db-instance \
    --db-instance-identifier lab-db \
    --db-instance-class db.t3.micro \
    --engine postgres
```{{exec}}

Check DB status:

`awslocal rds describe-db-instances --query "DBInstances[*].DBInstanceStatus"`{{exec}}

### Summary
You've explored **Object**, **NoSQL**, and **Relational** storage. These are the persistent layers of almost every cloud application.
