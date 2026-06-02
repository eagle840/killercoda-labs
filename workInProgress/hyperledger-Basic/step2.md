# Step 2: Deploying the Smart Contract

To get a deep dive into Fabric, check out the Docs: https://hyperledger-fabric.readthedocs.io/en/release-2.5/test_network.html

In Hyperledger Fabric, smart contracts are called **Chaincode**. For a network to process transactions, organizations must agree on a chaincode definition and "commit" it to a channel.

### 1. Create a Channel
A channel is a private "subnet" of communication between specific network members. Let's create a default channel named `mychannel`.

`./network.sh createChannel`{{exec}}

### 2. Deploy the Chaincode
We will use the `asset-transfer-basic` sample. This chaincode allows us to create, read, update, and delete assets on the ledger. 

The following command packages the Go chaincode, installs it on the peers of Org1 and Org2, and then commits the definition to the channel.

`./network.sh deployCC -ccn basic -ccp ../asset-transfer-basic/chaincode-go -ccl go`{{exec}}

**Argument Breakdown:**
*   **`-ccn basic`**: **Chaincode Name**. This specifies the name by which the contract will be identified on the channel.
*   **`-ccp ../...`**: **Chaincode Path**. Points to the directory containing the source code.
*   **`-ccl go`**: **Chaincode Language**. Tells the script to use the Go runtime environment. Fabric also supports `javascript`, `typescript`, and `java`.

*Note: This process may take 1-2 minutes as it compiles the Go code and builds Docker images for the chaincode containers.*

To checkout the go code:
`cat ../asset-transfer-basic/chaincode-go/chaincode.go`{{exec}}

And other languages:
`ls ../asset-transfer-basic/`{{exec}}

### 3. Verify Deployment
Once finished, check your Docker containers again. You will see new containers representing the running chaincode for each organization.

`docker ps --filter name=basic`{{exec}}

You are now ready to start transacting!
