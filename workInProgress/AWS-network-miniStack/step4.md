# Network Security

While Route Tables control traffic flow at the subnet level, **Security Groups** act as a virtual firewall for your individual resources (like EC2 instances). They control both inbound and outbound traffic.

In this step, we'll create two security groups:
1.  **Web-SG**: Allows web traffic from the internet.
2.  **DB-SG**: Only allows traffic coming from the Web-SG.

### 1. Create the Web Security Group

This group will be for resources in our **Public Subnet**.

```bash
# Create the Security Group
awslocal ec2 create-security-group \
    --group-name Web-SG \
    --description "Security group for public web servers" \
    --vpc-id $VPC_ID

# Extract the Group ID
WEB_SG_ID=$(awslocal ec2 describe-security-groups \
    --filters "Name=group-name,Values=Web-SG" \
    --query "SecurityGroups[0].GroupId" --output text)

# Allow Inbound HTTP (Port 80) from anywhere
awslocal ec2 authorize-security-group-ingress \
    --group-id $WEB_SG_ID \
    --protocol tcp --port 80 --cidr 0.0.0.0/0

# Allow Inbound SSH (Port 22) from anywhere (for the lab)
awslocal ec2 authorize-security-group-ingress \
    --group-id $WEB_SG_ID \
    --protocol tcp --port 22 --cidr 0.0.0.0/0
```{{exec}}

---

### 2. Create the Database Security Group

This group will be for resources in our **Private Subnet**. To be secure, it should **only** accept traffic from our Web servers, not the whole internet.

```bash
# Create the Security Group
awslocal ec2 create-security-group \
    --group-name DB-SG \
    --description "Security group for private databases" \
    --vpc-id $VPC_ID

# Extract the Group ID
DB_SG_ID=$(awslocal ec2 describe-security-groups \
    --filters "Name=group-name,Values=DB-SG" \
    --query "SecurityGroups[0].GroupId" --output text)

# Allow Inbound MySQL/Aurora (Port 3306) ONLY from the Web-SG
awslocal ec2 authorize-security-group-ingress \
    --group-id $DB_SG_ID \
    --protocol tcp --port 3306 --source-group $WEB_SG_ID
```{{exec}}

### 3. Verify the Rules

Let's check our work to ensure the rules are correctly applied.

```bash
awslocal ec2 describe-security-groups --group-ids $WEB_SG_ID $DB_SG_ID \
    --query "SecurityGroups[*].{Name:GroupName,Rules:IpPermissions}"
```{{exec}}

### Summary
You have successfully implemented a **Layered Security Architecture**:
*   **Web Servers**: Accessible from the internet on ports 80 and 22.
*   **Databases**: Accessible **only** from the Web Servers on port 3306.

Next, we'll launch some "mock" instances into these subnets to see how they look in the metadata.
