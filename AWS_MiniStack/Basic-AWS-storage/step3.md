# DynamoDB NoSQL

In this step, we will create a NoSQL table for flexible, key-value data storage.

---

## 1. Create a Table
Create a simple table for storing "Users".

```bash
awslocal dynamodb create-table \
    --table-name UsersTable \
    --attribute-definitions AttributeName=UserId,AttributeType=S \
    --key-schema AttributeName=UserId,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```{{exec}}

## 2. List Tables
Verify that the table has been successfully created.

```bash
awslocal dynamodb list-tables
```{{exec}}
