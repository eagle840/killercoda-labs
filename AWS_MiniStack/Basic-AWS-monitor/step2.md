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
