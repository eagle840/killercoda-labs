# Step 1: Environment Setup

Before we can start working with Hyperledger Fabric, we need to install some prerequisites and download the Fabric samples and binaries.

### 1. Update System
`sudo apt update`{{exec}}

### 2. Install Prerequisites
Fabric requires Docker, Docker Compose, and Go.

`sudo apt install -y docker.io docker-compose golang-go`{{exec}}

### 3. Download Fabric Samples and Binaries
`curl -sSL https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh | bash -s -- docker binary samples`{{exec}}

Wait for the download to complete. This will create a `fabric-samples` directory.

### 4. Bring up the Test Network
Navigate to the `test-network` directory and bring up the network. This script will create two organizations (Org1 and Org2), each with one peer, and an ordering service.

`cd fabric-samples/test-network`{{exec}}

`./network.sh up`{{exec}}

To see the full list for the script options:

`./network.sh -h`{{exec}}

For a detailed review of the script, see [Youtube Link](https://www.youtube.com/watch?v=3xpMzjjaq3U)

### 5. Confirm the Network is Running
Check the running Docker containers to see the Fabric nodes (Peers and Orderer).

`docker ps`{{exec}}

You should see the following three core components:
*   **`peer0.org1.example.com`**: A **Peer Node** for Organization 1. Peers are the fundamental actors in the network; they maintain the ledger and execute smart contracts (chaincode) to validate transactions.
*   **`peer0.org2.example.com`**: A **Peer Node** for Organization 2. In a permissioned network, each organization typically maintains its own peers to ensure they have a local, verified copy of the shared ledger.
*   **`orderer.example.com`**: The **Ordering Service Node**. It acts as the network's "clock," collecting transactions from peers, ordering them into blocks, and distributing those blocks back to all peers to maintain a single, consistent history.

Congratulations! You have a basic Hyperledger Fabric network running.
