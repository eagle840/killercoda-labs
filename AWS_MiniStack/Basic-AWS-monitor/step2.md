# Resource Tagging

In this step, we will learn how to apply and audit tags to enforce governance.

## 1. Apply Tags
Apply standard tags to a resource, such as a dummy user or bucket.

```bash
awslocal iam tag-user --user-name DevUser \
    --tags '{"Key": "Environment", "Value": "Dev"}' \
           '{"Key": "Project", "Value": "AWS-Lab"}'
```{{exec}}

## 2. Audit Tags
Use the Resource Groups Tagging API to find resources with specific tags.

```bash
awslocal resourcegroupstaggingapi get-resources \
    --tag-filters Key=Environment,Values=Dev
```{{exec}}
