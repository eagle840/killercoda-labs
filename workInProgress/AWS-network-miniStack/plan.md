# Lab Plan: AWS Networking & EC2 on MiniStack

## Goal
Transform the broad "AWS on MiniStack" lab into a focused, high-fidelity lab specifically covering AWS Networking (VPC, Subnets, Routing, Security Groups) and Compute (EC2, ECS).

## Scenario Metadata (index.json)
- **Title**: AWS Networking & EC2 on MiniStack
- **Description**: Master AWS VPCs, Subnets, and Instances using the MiniStack emulator. (v0.1.0)
- **Difficulty**: Intermediate
- **Estimated Time**: 45 minutes

## Lab Steps

### 1. Environment Setup (step1.md)
- **Content**:
    - Start MiniStack using `docker-compose`.
    - Install AWS CLI, `jq`, and `unzip`.
    - Configure AWS CLI for MiniStack (dummy credentials + endpoint alias).
    - Verify health check.

### 2. VPC & Multi-Subnet Foundations (step2.md)
- **Content**:
    - Create a VPC with CIDR `10.0.0.0/16`.
    - Create a **Public Subnet** `10.0.1.0/24`.
    - Create a **Private Subnet** `10.0.2.0/24`.
    - Extract and store `VPC_ID`, `PUBLIC_SUBNET_ID`, and `PRIVATE_SUBNET_ID`.

### 3. Routing & Internet Access (step3.md)
- **Content**:
    - **Public Routing**: Create an Internet Gateway (IGW), attach it to the VPC, and create a route table for the Public Subnet.
    - **Private Routing**: Allocate an Elastic IP (EIP), create a **NAT Gateway** in the Public Subnet, and create a separate route table for the Private Subnet pointing to the NAT Gateway.

### 4. Network Security (step4.md)
- **Content**:
    - Create a Security Group for "Web" (Public) and "DB" (Private).
    - Configure ingress rules to allow traffic between them.

### 5. Launching EC2 Instances (step5.md)
- **Content**:
    - Boot a mock EC2 instance in both subnets.
    - Validate addressing and placement.
    - Discuss the architectural difference (Direct internet vs NAT-traversed).

### 6. Advanced: Containers with ECS (step6.md)
- **Content**:
    - Create an ECS Cluster.
    - Register a Task Definition for `nginx`.
    - Run the Task in the Public Subnet.
    - `curl` the running Nginx service on port 8080.

### 7. Wrap-up (finish.md)
- **Content**:
    - Summary of the Public/Private architecture.
    - Recap of IGW vs NAT Gateway roles.

## Assets
- `docker-compose.yml`: Standard MiniStack setup.
- `task-def.json`: ECS blueprint for Nginx.
