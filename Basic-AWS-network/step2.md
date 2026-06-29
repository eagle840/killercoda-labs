# Networking

AWS VPCs are managed through the **`aws ec2`** command set. The CLI exposes commands to **create, list, modify, and delete** VPCs and all related networking components (subnets, route tables, IGWs, NAT gateways, security groups, etc.).

---

## 🧱 Core VPC Commands (Create, View, Delete)

### **Create a VPC**
```
awslocal ec2 create-vpc --cidr-block 10.0.0.0/16 \
  --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=MyVPC}]'
```{{exec}}

### **List VPCs**
```
awslocal ec2 describe-vpcs
```{{exec}}

### Pull the vpc-id
```
VPC_ID=$(awslocal ec2 describe-vpcs \
  --filters "Name=tag:Name,Values=MyVPC" \
  --query "Vpcs[0].VpcId" --output text)
```{{exec}}

---

## 🌐 Subnets & Gateways

### **Create a subnet**
```
awslocal ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24
```{{exec}}

### **Create an Internet Gateway (IGW)**
```
awslocal ec2 create-internet-gateway
```{{exec}}

### **Attach IGW to VPC**
```
# Note: You'll need the IGW ID from the previous command output in a real scenario
# For this lab, we're exploring the commands
```

---

## 🔒 Security Groups

### **Create a security group**
```
awslocal ec2 create-security-group \
  --group-name MySG \
  --description "My security group" \
  --vpc-id $VPC_ID
```{{exec}}

### **Authorize inbound SSH (Port 22)**
```
awslocal ec2 authorize-security-group-ingress \
  --group-id sg-123 \
  --protocol tcp --port 22 --cidr 0.0.0.0/0
```{{exec}}

---

## 🗂️ Summary Table

| Task | AWS CLI Command |
|------|-----------------|
| Create VPC | `create-vpc` |
| Create subnet | `create-subnet` |
| Create IGW | `create-internet-gateway` |
| Attach IGW | `attach-internet-gateway` |
| Create route table | `create-route-table` |
| Create security group | `create-security-group` |
| Add SG rule | `authorize-security-group-ingress` |

Next, we will look at **Compute** resources and how to run your first instances.
