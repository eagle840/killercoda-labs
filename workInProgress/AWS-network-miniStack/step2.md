# VPC & Multi-Subnet Foundations

In this step, we will build a professional-grade network architecture. Real-world AWS environments use multiple subnets to isolate resources:
*   **Public Subnets**: Directly accessible from the internet (e.g., for Web Servers).
*   **Private Subnets**: Not directly accessible, but can reach the internet for updates via a NAT Gateway (e.g., for Databases).

### 1. Create the VPC

We'll start by creating a VPC with a `10.0.0.0/16` CIDR block.

```bash
awslocal ec2 create-vpc --cidr-block 10.0.0.0/16 \
  --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=LabVPC}]'
```{{exec}}

Extract and store the `VPC_ID`:

```bash
VPC_ID=$(awslocal ec2 describe-vpcs \
  --filters "Name=tag:Name,Values=LabVPC" \
  --query "Vpcs[0].VpcId" --output text)

echo "VPC_ID=$VPC_ID"
```{{exec}}

### 2. Create the Public Subnet

This subnet will host our internet-facing resources. We'll use the range `10.0.1.0/24`.

```bash
awslocal ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24 \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=PublicSubnet}]'
```{{exec}}

Extract the `PUBLIC_SUBNET_ID`:

```bash
PUBLIC_SUBNET_ID=$(awslocal ec2 describe-subnets \
  --filters "Name=tag:Name,Values=PublicSubnet" \
  --query "Subnets[0].SubnetId" --output text)

echo "PUBLIC_SUBNET_ID=$PUBLIC_SUBNET_ID"
```{{exec}}

### 3. Create the Private Subnet

This subnet will host our backend resources. We'll use the range `10.0.2.0/24`.

```bash
awslocal ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.2.0/24 \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=PrivateSubnet}]'
```{{exec}}

Extract the `PRIVATE_SUBNET_ID`:

```bash
PRIVATE_SUBNET_ID=$(awslocal ec2 describe-subnets \
  --filters "Name=tag:Name,Values=PrivateSubnet" \
  --query "Subnets[0].SubnetId" --output text)

echo "PRIVATE_SUBNET_ID=$PRIVATE_SUBNET_ID"
```{{exec}}

### Summary
You have now established a dual-subnet foundation:
*   **VPC**: `10.0.0.0/16`
*   **Public Subnet**: `10.0.1.0/24`
*   **Private Subnet**: `10.0.2.0/24`

In the next step, we will wire up the **Internet Gateway** and **NAT Gateway** to provide the appropriate internet access for each.
