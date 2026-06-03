# Step 3: Interacting with the Ledger

To follow in the Fabric docs: [interacting-with-the-network](https://hyperledger-fabric.readthedocs.io/en/release-2.5/test_network.html#interacting-with-the-network)

Now that the chaincode is deployed, we can use the Fabric `peer` CLI to interact with it. To do this, we must tell the CLI which peer we are "acting" as.


### 1. Set the Environment Variables (Org1)
We will act as the Administrator of **Org1**. Copy and run the following block to set up your environment:

```bash
export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=$PWD/../config/
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051
```{{exec}}

`peer -h`{{exec}}

### 2. Initialize the Ledger
The sample chaincode has an `InitLedger` function that populates the blockchain with some starting data.

`peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"InitLedger","Args":[]}'`{{exec}}

### 3. Query the Data
Let's see all the assets that were just created.

`peer chaincode query -C mychannel -n basic -c '{"Args":["GetAllAssets"]}' | jq`{{exec}}

### 4. Create a New Asset
Now, let's put your own data on the blockchain. We will create a new asset named `asset7`.

`peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"CreateAsset","Args":["asset7","yellow","5","Tom","1300"]}'`{{exec}}

### 5. Read the New Asset
Verify that your data is stored securely and immutably.

`peer chaincode query -C mychannel -n basic -c '{"Args":["ReadAsset","asset7"]}' | jq`{{exec}}

You have successfully interacted with a Hyperledger Fabric ledger!
