# Routing & Internet Access

Now that we have our subnets, we need to tell AWS how traffic should flow in and out of them. We do this using **Route Tables** and **Gateways**.

### 1. Connect the Public Subnet to the Internet

To allow the Public Subnet to reach the internet, we need an **Internet Gateway (IGW)**.

```bash
# Create the IGW
awslocal ec2 create-internet-gateway --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=LabIGW}]'

# Extract the ID
IGW_ID=$(awslocal ec2 describe-internet-gateways \
  --filters "Name=tag:Name,Values=LabIGW" \
  --query "InternetGateways[0].InternetGatewayId" --output text)

# Attach it to your VPC
awslocal ec2 attach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID
```{{exec}}

Now, create a **Public Route Table** and add a rule that sends all outbound traffic (`0.0.0.0/0`) to that IGW.

```bash
# Create Route Table
awslocal ec2 create-route-table --vpc-id $VPC_ID --tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=PublicRT}]'

# Extract ID
PUBLIC_RT_ID=$(awslocal ec2 describe-route-tables \
  --filters "Name=tag:Name,Values=PublicRT" \
  --query "RouteTables[0].RouteTableId" --output text)

# Create the route to the Internet Gateway
awslocal ec2 create-route --route-table-id $PUBLIC_RT_ID --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW_ID

# Associate it with the Public Subnet
awslocal ec2 associate-route-table --route-table-id $PUBLIC_RT_ID --subnet-id $PUBLIC_SUBNET_ID
```{{exec}}

---

### 2. Connect the Private Subnet via NAT Gateway

Resources in a Private Subnet cannot be reached from the internet, but they often need to "call out" to download updates. For this, we use a **NAT Gateway**. 

> **Architecture Note**: A NAT Gateway must live in a **Public Subnet** (so it can reach the IGW) but it serves the **Private Subnet**.

First, we need an **Elastic IP (EIP)** for the NAT Gateway:

```bash
# Allocate an EIP
ALLOCATION_ID=$(awslocal ec2 allocate-address --query "AllocationId" --output text)

# Create the NAT Gateway (this may take a few seconds in real AWS)
awslocal ec2 create-nat-gateway --subnet-id $PUBLIC_SUBNET_ID --allocation-id $ALLOCATION_ID \
  --tag-specifications 'ResourceType=natgateway,Tags=[{Key=Name,Value=LabNAT}]'

# Extract the ID (Wait a moment if needed)
NAT_GW_ID=$(awslocal ec2 describe-nat-gateways \
  --filter "Name=tag:Name,Values=LabNAT" \
  --query "NatGateways[0].NatGatewayId" --output text)
```{{exec}}

Finally, create a **Private Route Table** that sends traffic to the NAT Gateway.

```bash
# Create Route Table
awslocal ec2 create-route-table --vpc-id $VPC_ID --tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=PrivateRT}]'

# Extract ID
PRIVATE_RT_ID=$(awslocal ec2 describe-route-tables \
  --filters "Name=tag:Name,Values=PrivateRT" \
  --query "RouteTables[0].RouteTableId" --output text)

# Create the route to the NAT Gateway
awslocal ec2 create-route --route-table-id $PRIVATE_RT_ID --destination-cidr-block 0.0.0.0/0 --nat-gateway-id $NAT_GW_ID

# Associate it with the Private Subnet
awslocal ec2 associate-route-table --route-table-id $PRIVATE_RT_ID --subnet-id $PRIVATE_SUBNET_ID
```{{exec}}

### Summary
Your network is now fully wired:
*   **Public Subnet** $\rightarrow$ **Route Table** $\rightarrow$ **Internet Gateway**.
*   **Private Subnet** $\rightarrow$ **Route Table** $\rightarrow$ **NAT Gateway** (in Public Subnet) $\rightarrow$ **Internet Gateway**.

Next, we'll secure these subnets with **Security Groups**.
