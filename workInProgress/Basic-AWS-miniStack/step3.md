# Networking

**Short answer:**  
AWS VPCs are managed through the **`aws ec2`** command set. The CLI exposes commands to **create, list, modify, and delete** VPCs and all related networking components (subnets, route tables, IGWs, NAT gateways, security groups, etc.). Below is a structured, practical breakdown of the most important commands, with examples grounded in the official AWS documentation.

---

## 🧱 Core VPC Commands (Create, View, Delete)

### **Create a VPC**
```
aws ec2 create-vpc --cidr-block 10.0.0.0/16 \
  --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=MyVPC}]'
```
Creates a new VPC with a CIDR block.   [AWS Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/getting-started-with-amazon-vpc-using-the-aws-cli.html)

### **List VPCs**
```
aws ec2 describe-vpcs
```

### **Modify VPC attributes**
Enable DNS support and hostnames:
```
aws ec2 modify-vpc-attribute --vpc-id vpc-123 --enable-dns-support
aws ec2 modify-vpc-attribute --vpc-id vpc-123 --enable-dns-hostnames
```
  [AWS Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/getting-started-with-amazon-vpc-using-the-aws-cli.html)

### **Delete a VPC**
```
aws ec2 delete-vpc --vpc-id vpc-123
```

---

## 🌐 Subnets

### **Create a subnet**
```
aws ec2 create-subnet --vpc-id vpc-123 --cidr-block 10.0.1.0/24
```

### **List subnets**
```
aws ec2 describe-subnets --filters Name=vpc-id,Values=vpc-123
```

### **Delete a subnet**
```
aws ec2 delete-subnet --subnet-id subnet-123
```

---

## 🌍 Internet Gateways (IGW)

### **Create an IGW**
```
aws ec2 create-internet-gateway
```

### **Attach IGW to VPC**
```
aws ec2 attach-internet-gateway --internet-gateway-id igw-123 --vpc-id vpc-123
```

### **Delete IGW**
```
aws ec2 delete-internet-gateway --internet-gateway-id igw-123
```

---

## 🔁 Route Tables

### **Create a route table**
```
aws ec2 create-route-table --vpc-id vpc-123
```

### **Create a route (e.g., to IGW)**
```
aws ec2 create-route \
  --route-table-id rtb-123 \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id igw-123
```

### **Associate route table with subnet**
```
aws ec2 associate-route-table \
  --route-table-id rtb-123 \
  --subnet-id subnet-123
```

### **List route tables**
```
aws ec2 describe-route-tables
```

---

## 🔒 Security Groups

### **Create a security group**
```
aws ec2 create-security-group \
  --group-name MySG \
  --description "My security group" \
  --vpc-id vpc-123
```

### **Authorize inbound rule**
```
aws ec2 authorize-security-group-ingress \
  --group-id sg-123 \
  --protocol tcp --port 22 --cidr 0.0.0.0/0
```

### **List security groups**
```
aws ec2 describe-security-groups
```

---

## 🚪 NAT Gateways

### **Allocate Elastic IP**
```
aws ec2 allocate-address
```

### **Create NAT Gateway**
```
aws ec2 create-nat-gateway \
  --subnet-id subnet-public \
  --allocation-id eipalloc-123
```

NAT gateways incur cost; AWS notes ~$0.045/hr plus data processing.   [AWS Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/getting-started-with-amazon-vpc-using-the-aws-cli.html)

### **Delete NAT Gateway**
```
aws ec2 delete-nat-gateway --nat-gateway-id nat-123
```

---

## 🔗 VPC Endpoints (PrivateLink)

### **Create an interface endpoint**
```
aws ec2 create-vpc-endpoint \
  --vpc-id vpc-123 \
  --service-name com.amazonaws.eu-west-2.s3 \
  --vpc-endpoint-type Interface \
  --subnet-ids subnet-123
```

---

## 🧰 Helpful Meta Commands

### **Check your identity**
```
aws sts get-caller-identity
```
Confirms your AWS account and IAM identity.   [AWS Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/getting-started-with-amazon-vpc-using-the-aws-cli.html)

### **Check CLI configuration**
```
aws configure list
```
  [AWS Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/getting-started-with-amazon-vpc-using-the-aws-cli.html)

---

## 🗂️ Summary Table

| Task | AWS CLI Command |
|------|-----------------|
| Create VPC | `create-vpc` |
| Modify VPC DNS | `modify-vpc-attribute` |
| Create subnet | `create-subnet` |
| Create IGW | `create-internet-gateway` |
| Attach IGW | `attach-internet-gateway` |
| Create route table | `create-route-table` |
| Add route | `create-route` |
| Associate route table | `associate-route-table` |
| Create NAT gateway | `create-nat-gateway` |
| Create security group | `create-security-group` |
| Add SG rule | `authorize-security-group-ingress` |

---

## Want something more specific?
I can generate:

- A **full VPC creation script** (public + private subnets, IGW, NAT, routes)  
- A **minimal VPC setup** for testing  
- A **diagram + commands** for a typical 3‑tier architecture  
- A **cleanup script** to delete everything safely  

What do you want to build next?