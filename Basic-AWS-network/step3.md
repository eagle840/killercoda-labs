# Security Groups & IGW

In this step, we will configure connectivity and security for your network.

---

## 1. Create an Internet Gateway (IGW)
An IGW enables resources in your public subnets to communicate with the internet.

```bash
awslocal ec2 create-internet-gateway
```{{exec}}

*(Note: You would typically attach this to the VPC created in Step 2)*

---

## 2. Security Groups
Security Groups act as a virtual firewall for your EC2 instances to control inbound and outbound traffic.

### A. Create a Security Group
```bash
# First, retrieve the VPC ID again if not in the same session
VPC_ID=$(awslocal ec2 describe-vpcs \
  --filters "Name=tag:Name,Values=MyVPC" \
  --query "Vpcs[0].VpcId" --output text)

awslocal ec2 create-security-group \
  --group-name MySG \
  --description "My security group" \
  --vpc-id $VPC_ID
```{{exec}}

### B. Authorize inbound SSH (Port 22)
```bash
# Retrieve the group ID
SG_ID=$(awslocal ec2 describe-security-groups \
  --filters "Name=group-name,Values=MySG" \
  --query "SecurityGroups[0].GroupId" --output text)

awslocal ec2 authorize-security-group-ingress \
  --group-id $SG_ID \
  --protocol tcp --port 22 --cidr 0.0.0.0/0
```{{exec}}
