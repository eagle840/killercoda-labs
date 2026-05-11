# Networking And EC2

**Short answer:**  
AWS VPCs are managed through the **`aws ec2`** command set. The CLI exposes commands to **create, list, modify, and delete** VPCs and all related networking components (subnets, route tables, IGWs, NAT gateways, security groups, etc.). Below is a structured, practical breakdown of the most important commands, with examples grounded in the official AWS documentation.

---

## 🧱 Core VPC Commands (Create, View, Delete)

### **Create a VPC**
```
awslocal ec2 create-vpc --cidr-block 10.0.0.0/16 \
  --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=MyVPC}]'
```{{exec}}
Creates a new VPC with a CIDR block.   [AWS Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/getting-started-with-amazon-vpc-using-the-aws-cli.html)

### **List VPCs**
```
awslocal ec2 describe-vpcs
```{{exec}}

### **Modify VPC attributes**
Enable DNS support and hostnames:
```
awslocal ec2 modify-vpc-attribute --vpc-id vpc-123 --enable-dns-support
awslocal ec2 modify-vpc-attribute --vpc-id vpc-123 --enable-dns-hostnames
```{{exec}}
  [AWS Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/getting-started-with-amazon-vpc-using-the-aws-cli.html)

### **Delete a VPC**
```
awslocal ec2 delete-vpc --vpc-id vpc-123
```{{exec}}

---

## 🌐 Subnets

### **Create a subnet**
```
awslocal ec2 create-subnet --vpc-id vpc-123 --cidr-block 10.0.1.0/24
```{{exec}}

### **List subnets**
```
awslocal ec2 describe-subnets --filters Name=vpc-id,Values=vpc-123
```{{exec}}

### **Delete a subnet**
```
awslocal ec2 delete-subnet --subnet-id subnet-123
```{{exec}}

---

## 🌍 Internet Gateways (IGW)

### **Create an IGW**
```
awslocal ec2 create-internet-gateway
```{{exec}}

### **Attach IGW to VPC**
```
awslocal ec2 attach-internet-gateway --internet-gateway-id igw-123 --vpc-id vpc-123
```{{exec}}

### **Delete IGW**
```
awslocal ec2 delete-internet-gateway --internet-gateway-id igw-123
```{{exec}}

---

## 🔁 Route Tables

### **Create a route table**
```
awslocal ec2 create-route-table --vpc-id vpc-123
```{{exec}}

### **Create a route (e.g., to IGW)**
```
awslocal ec2 create-route \
  --route-table-id rtb-123 \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id igw-123
```{{exec}}

### **Associate route table with subnet**
```
awslocal ec2 associate-route-table \
  --route-table-id rtb-123 \
  --subnet-id subnet-123
```{{exec}}

### **List route tables**
```
awslocal ec2 describe-route-tables
```{{exec}}

---

## 🔒 Security Groups

### **Create a security group**
```
awslocal ec2 create-security-group \
  --group-name MySG \
  --description "My security group" \
  --vpc-id vpc-123
```{{exec}}

### **Authorize inbound rule**
```
awslocal ec2 authorize-security-group-ingress \
  --group-id sg-123 \
  --protocol tcp --port 22 --cidr 0.0.0.0/0
```{{exec}}

### **List security groups**
```
awslocal ec2 describe-security-groups
```{{exec}}

---

## 🚪 NAT Gateways

### **Allocate Elastic IP**
```
awslocal ec2 allocate-address
```{{exec}}

### **Create NAT Gateway**
```
awslocal ec2 create-nat-gateway \
  --subnet-id subnet-public \
  --allocation-id eipalloc-123
```{{exec}}

NAT gateways incur cost; AWS notes ~$0.045/hr plus data processing.   [AWS Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/getting-started-with-amazon-vpc-using-the-aws-cli.html)

### **Delete NAT Gateway**
```
awslocal ec2 delete-nat-gateway --nat-gateway-id nat-123
```{{exec}}

---

## 🔗 VPC Endpoints (PrivateLink)

### **Create an interface endpoint**
```
awslocal ec2 create-vpc-endpoint \
  --vpc-id vpc-123 \
  --service-name com.amazonaws.eu-west-2.s3 \
  --vpc-endpoint-type Interface \
  --subnet-ids subnet-123
```{{exec}}

---

## 🧰 Helpful Meta Commands

### **Check your identity**
```
awslocal sts get-caller-identity
```{{exec}}
Confirms your AWS account and IAM identity.   [AWS Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/getting-started-with-amazon-vpc-using-the-aws-cli.html)

### **Check CLI configuration**
```
awslocal configure list
```{{exec}}

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

# EC2


MINISTACK mocks an EC2 (ie, its just the metadata, not a real instance)


In **MiniStack**, EC2 instances are handled using a "Container-as-a-Service" model. Unlike the real AWS cloud where EC2 runs on Xen or Nitro hypervisors, MiniStack emulates the EC2 API by spinning up **Docker containers** on your host machine to represent those "instances."

Here is the breakdown of how they are booted and controlled.

---

### 1. How EC2 is Handled

MiniStack acts as a middleman. When you send an EC2 command, it translates that request into Docker API calls.

* **Instance Lifecycle:** When you "start" an instance, MiniStack pulls a lightweight Linux image (often Alpine or a specialized MiniStack AMI-shim) and runs it as a container.
* **Networking:** MiniStack maps ports and creates a virtual network within Docker to simulate VPC behavior.
* **Storage:** EBS volumes are typically emulated as Docker volumes or local directories.
* **AMIs:** Since MiniStack can't run real Amazon Machine Images (which are `.raw` or `.vmdk` files), it maps `ImageId` (like `ami-12345`) to specific Docker images.

---

### 2. Booting Instances via AWS CLI

To boot an instance, you use the standard `aws ec2 run-instances` command, but you must point it to the MiniStack endpoint (usually `http://localhost:4566`).

**The Command:**

```bash
aws ec2 run-instances \
    --image-id ami-000000 \
    --count 1 \
    --instance-type t2.micro \
    --key-name my-key \
    --endpoint-url http://localhost:4566
```{{exec}}

> **Note on AMI IDs:** In MiniStack, the actual ID often doesn't matter unless you've mapped specific Docker images to specific IDs in your config. Usually, a dummy ID like `ami-000000` will trigger a default container boot.

---

### 3. Controlling Instances

Once booted, you manage the instances just like you would in production, provided you keep the `--endpoint-url` flag (or use a wrapper like `awslocal`).

#### **Checking Status**

`aws ec2 describe-instances --endpoint-url http://localhost:456`{{exec}}

#### **Accessing the Instance (SSH Emulation)**

Because these are containers, "SSHing" is actually handled via port mapping. MiniStack will typically map a high port on your localhost (e.g., `12862`) to port `22` inside the container.

```bash
ssh -p 12862 root@localhost
```{{exec}}

#### **Stopping and Terminating**


# To stop
`aws ec2 stop-instances --instance-ids i-123456 --endpoint-url http://localhost:4566`{{exec}}

# To delete the container entirely
`aws ec2 terminate-instances --instance-ids i-123456 --endpoint-url http://localhost:4566`{{exec}}



---

### Summary Table: Cloud vs. MiniStack

| Feature | AWS (Real) | MiniStack |
| --- | --- | --- |
| **Virtualization** | Nitro/KVM Hypervisor | Docker Containers |
| **Boot Time** | 30s - 2 minutes | ~2 seconds |
| **Cost** | Hourly/Per-second | Free (Local resources) |
| **IP Addresses** | Real VPC Private/Public IPs | Docker Bridge Network IPs |
| **Persistence** | Durable EBS | Volatile (unless volume mapping is configured) |


### ECS


To run Nginx on ECS in **MiniStack**, you follow the standard AWS workflow. Unlike EC2, MiniStack **will** actually spawn a real Docker container on your host when you start an ECS task.

Here is the step-by-step process to get Nginx running.

---

### 1. Create an ECS Cluster

First, you need a logical grouping for your services.

```bash
aws ecs create-cluster --cluster-name my-cluster \
    --endpoint-url http://localhost:4566

```{{exec}}

### 2. Register a Task Definition

This is the "blueprint" that tells ECS to use the Nginx image and which ports to open. Create a file named `task-def.json`:

```json
{
    "family": "nginx-task",
    "containerDefinitions": [
        {
            "name": "web-server",
            "image": "nginx:latest",
            "portMappings": [
                {
                    "containerPort": 80,
                    "hostPort": 8080,
                    "protocol": "tcp"
                }
            ],
            "essential": true
        }
    ]
}

```{{copy}}

Then register it:

```bash
aws ecs register-task-definition --cli-input-json file://task-def.json \
    --endpoint-url http://localhost:4566

```{{exec}}

### 3. Run the Task

Now, tell MiniStack to actually start the container based on that blueprint.

```bash
aws ecs run-task --cluster my-cluster --task-definition nginx-task \
    --count 1 --launch-type FARGATE \
    --network-configuration "awsvpcConfiguration={subnets=[subnet-000000],assignPublicIp=ENABLED}" \
    --endpoint-url http://localhost:4566

```{{exec}}

*(Note: In MiniStack/LocalStack, the subnet ID doesn't have to exist unless you've strictly configured VPC validation, but `subnet-000000` is the common mock default.)*

---

### 4. Verify it’s working

Now, if you run your original command, you should see the container:

`docker ps`{{exec}}

**What to expect in `docker ps`:**
You will see a container with a name like `ministack_ecs_...` or a random hash running the `nginx:latest` image.

**Test the Web Server:**
Since we mapped the container's port 80 to your host's port **8080**, you can simply open your browser or use curl:

```bash
curl http://localhost:8080

```

You should see the "Welcome to nginx!" HTML response.

---

### Why this works (and EC2 didn't)

* **EC2 in MiniStack:** Is mostly a "metadata mock." It mimics the API so your scripts don't crash, but it doesn't want to eat up your RAM by booting a whole Linux VM for every instance.
* **ECS in MiniStack:** Is "infrastructure-backed." It recognizes that the whole point of ECS is to manage containers, so it hooks directly into your local Docker engine to pull the image and run it.

**Pro-tip:** If the container doesn't show up, check your MiniStack logs (`docker logs <ministack-container-name>`). It might be failing to pull the `nginx` image from Docker Hub if your internet is spotty or Docker is throttled.
