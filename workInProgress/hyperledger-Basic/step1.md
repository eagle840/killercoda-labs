# Step 1: Environment Setup

Before we can start working with Hyperledger Fabric, we need to install some prerequisites and download the Fabric samples and binaries.

### 1. Update System
`sudo apt update`{{exec}}

### 2. Install Prerequisites
Fabric requires Docker, Docker Compose, and Go.

`sudo apt install -y docker.io docker-compose golang-go`{{exec}}

### 3. Download Fabric Samples and Binaries
`curl -sSL https://bit.ly/2YSbOBx | bash -s`{{exec}}

Wait for the download to complete. This will create a `fabric-samples` directory.

### 4. Bring up the Test Network
Navigate to the `test-network` directory and bring up the network. This script will create two organizations (Org1 and Org2), each with one peer, and an ordering service.

`cd fabric-samples/test-network`{{exec}}

`./network.sh up`{{exec}}

### 5. Confirm the Network is Running
Check the running Docker containers to see the Fabric nodes (Peers and Orderer).

`docker ps`{{exec}}

You should see containers for:
*   `peer0.org1.example.com`
*   `peer0.org2.example.com`
*   `orderer.example.com`

Congratulations! You have a basic Hyperledger Fabric network running.
