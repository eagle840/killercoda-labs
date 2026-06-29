# RDS Relational Database

In this step, we will provision a relational database instance to store structured data.

---

## 1. Create a DB Instance
Provision an RDS instance. MiniStack will emulate the creation of this database service.

```bash
awslocal rds create-db-instance \
    --db-instance-identifier lab-db \
    --db-instance-class db.t3.micro \
    --engine postgres
```{{exec}}

## 2. Check DB Status
Verify that the database instance is being created.

```bash
awslocal rds describe-db-instances --query "DBInstances[*].DBInstanceStatus"
```{{exec}}
