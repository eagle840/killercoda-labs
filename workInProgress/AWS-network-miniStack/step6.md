# Advanced: Containers with ECS

In the previous step, we saw how EC2 is "mocked" for metadata. However, for **ECS (Elastic Container Service)**, MiniStack provides **Infrastructure-Backed** compute. 

When you run an ECS task, MiniStack will actually talk to your local Docker engine and spin up a real container.

### 1. Create an ECS Cluster

An ECS Cluster is a logical grouping of services and tasks.

```bash
awslocal ecs create-cluster --cluster-name lab-cluster
```{{exec}}

### 2. Register a Task Definition

A **Task Definition** is the blueprint for your container (like a `docker-compose` file for a single task). We have provided a `task-def.json` file that uses the `nginx:latest` image and maps port **80** in the container to port **8080** on your host.

```bash
awslocal ecs register-task-definition --cli-input-json file://task-def.json
```{{exec}}

### 3. Run the Task

Now, let's tell ECS to start a container based on that blueprint. We'll "place" it in our Public Subnet.

```bash
awslocal ecs run-task --cluster lab-cluster --task-definition nginx-task \
    --count 1 --launch-type FARGATE \
    --network-configuration "awsvpcConfiguration={subnets=[$PUBLIC_SUBNET_ID],assignPublicIp=ENABLED}"
```{{exec}}

### 4. Verify the "Real" Resource

Since ECS is infrastructure-backed, you can see the result using standard Docker commands!

```bash
docker ps --filter "name=ministack_ecs"
```{{exec}}

Wait a few seconds for the status to show `Up`, then try to reach the web server:

```bash
curl http://localhost:8080
```{{exec}}

### Summary
You've now seen the full spectrum of MiniStack compute:
1.  **EC2**: Fast metadata mocks for architecture validation.
2.  **ECS**: Real-world container execution for functional testing.

In the final step, we'll review what we've built.
