# Launching EC2 Instances

In this step, we will request compute resources to live inside our subnets. 

### A Note on MiniStack & EC2
In **MiniStack**, EC2 instances are handled as **Metadata Mocks**. 
*   **Real AWS**: Launching an instance starts a full Virtual Machine.
*   **MiniStack**: Launching an instance creates a record in the local database. It validates your architecture (Subnet IDs, Security Groups) but doesn't eat up your RAM by booting a heavy VM.

This is perfect for testing your **Control Plane** (your CLI scripts and automation) without the cost or time of real cloud resources.

---

### 1. Launch a Web Instance in the Public Subnet

We'll use the standard `run-instances` command. Notice how we reference the `PUBLIC_SUBNET_ID` and `WEB_SG_ID` we created earlier.

```bash
awslocal ec2 run-instances \
    --image-id ami-12345678 \
    --count 1 \
    --instance-type t2.micro \
    --subnet-id $PUBLIC_SUBNET_ID \
    --security-group-ids $WEB_SG_ID \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=WebServer}]'
```{{exec}}

### 2. Launch a Database Instance in the Private Subnet

Now let's do the same for our private backend.

```bash
awslocal ec2 run-instances \
    --image-id ami-87654321 \
    --count 1 \
    --instance-type t3.medium \
    --subnet-id $PRIVATE_SUBNET_ID \
    --security-group-ids $DB_SG_ID \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=DBServer}]'
```{{exec}}

---

### 3. Verify the Architecture

Let's look at our instances and see how they are mapped to our network.

```bash
awslocal ec2 describe-instances \
    --query "Reservations[*].Instances[*].{Name:Tags[0].Value,ID:InstanceId,Subnet:SubnetId,PrivateIP:PrivateIpAddress,PublicIP:PublicIpAddress}"
```{{exec}}

**Look closely at the output:**
*   The **WebServer** is in your Public Subnet.
*   The **DBServer** is in your Private Subnet.
*   In a real environment, the **WebServer** would have a Public IP, while the **DBServer** would only have a Private IP.

### Summary
By "booting" these instances, you've proven that your network IDs and security group mappings are valid. 

In the next step, we'll see **Infrastructure-Backed** compute by using **ECS**, which will spin up a real, functional Nginx container on your machine!
