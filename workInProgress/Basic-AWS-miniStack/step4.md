# Compute (EC2 & ECS)

In **MiniStack**, compute resources are handled using a "Container-as-a-Service" model. Unlike the real AWS cloud where EC2 runs on hypervisors, MiniStack emulates these APIs by spinning up **Docker containers** on your host machine.

---

## 1. Booting EC2 Instances

To boot an instance, you use the standard `run-instances` command. MiniStack translates this request into a Docker container.

### **A. Run an Instance**
```bash
awslocal ec2 run-instances \
    --image-id ami-000000 \
    --count 1 \
    --instance-type t2.micro \
    --key-name my-key
```{{exec}}

> **Note on AMI IDs:** In MiniStack, a dummy ID like `ami-000000` triggers a default container boot.

### **B. Check Status**
```bash
awslocal ec2 describe-instances
```{{exec}}

### **C. Access the Instance (SSH Emulation)**
Because these are containers, MiniStack maps a high port on your localhost to port 22 inside the container.
```bash
# Example (Port will vary, check describe-instances output)
# ssh -p <MappedPort> root@localhost
```

---

## 2. Elastic Container Service (ECS)

ECS manages containerized applications. MiniStack hooks directly into your local Docker engine to run these tasks.

### **A. Create an ECS Cluster**
```bash
awslocal ecs create-cluster --cluster-name my-cluster
```{{exec}}

### **B. Register a Task Definition**
Create the "blueprint" for your Nginx server:
```bash
cat <<EOF > task-def.json
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
EOF
```{{exec}}

Register it:
```bash
awslocal ecs register-task-definition --cli-input-json file://task-def.json
```{{exec}}

### **C. Run the Task**
```bash
awslocal ecs run-task --cluster my-cluster --task-definition nginx-task \
    --count 1 --launch-type FARGATE \
    --network-configuration "awsvpcConfiguration={subnets=[subnet-000000],assignPublicIp=ENABLED}"
```{{exec}}

---

## 3. Verify Your Deployment

Check if Docker has started the new containers:
```bash
docker ps
```{{exec}}

**Test the Web Server:**
Since we mapped port 80 to **8080**, try to reach Nginx:
```bash
curl http://localhost:8080
```{{exec}}

### Summary
You've explored **Server-based** (EC2) and **Container-orchestrated** (ECS) compute. While EC2 in MiniStack is a lightweight mock, ECS provides a full-fidelity container experience.
