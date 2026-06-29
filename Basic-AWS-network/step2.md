# VPC & Subnets

In this step, we will create the core network foundation: the VPC and its subnets.

---

## 1. Create a VPC
A Virtual Private Cloud (VPC) is your isolated network environment in AWS.

```bash
awslocal ec2 create-vpc --cidr-block 10.0.0.0/16 \
  --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=MyVPC}]'
```{{exec}}

## 2. Identify your VPC
Pull the `vpc-id` to use in subsequent commands.

```bash
VPC_ID=$(awslocal ec2 describe-vpcs \
  --filters "Name=tag:Name,Values=MyVPC" \
  --query "Vpcs[0].VpcId" --output text)
echo "VPC ID: $VPC_ID"
```{{exec}}

## 3. Create Subnets
Subnets allow you to segment your VPC into smaller, isolated networks.

```bash
awslocal ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24 \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=PublicSubnet}]'
```{{exec}}
