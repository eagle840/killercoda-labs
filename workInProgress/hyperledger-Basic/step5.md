# Step 5: Verifying Ledger Privacy

In this final step, we will witness the power of a permissioned blockchain. We will create a "Secret" asset as Org1 and prove that Org2 cannot see the sensitive details.

### 1. Set Environment as Org1
First, ensure you are acting as the **Org1 Admin**.

```bash
export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=$PWD/../config/
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051
```{{exec}}

### 2. Create a Private Asset (The "Transient" Way)
Private data is never sent in the main transaction body (to keep it out of logs). Instead, it is sent in a **Transient Map**. 

Let's create `asset1` with a secret price of `99`.

`export ASSET_PROPERTIES=$(echo -n "{\"objectType\":\"asset\",\"assetID\":\"asset1\",\"color\":\"green\",\"size\":20,\"owner\":\"Tom\",\"appraisedValue\":99}" | base64 | tr -d '\n')`{{exec}}

`peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n private -c '{"function":"CreateAsset","Args":[]}' --transient "{\"asset_properties\":\"$ASSET_PROPERTIES\"}"`{{exec}}

### 3. Query as Org1 (Success)
As a member of the collection, Org1 can see the full details, including the `appraisedValue`.

`peer chaincode query -C mychannel -n private -c '{"Args":["ReadAssetPrivateData","assetCollection","asset1"]}'`{{exec}}

### 4. Switch Environment to Org2
Now, let's see what the "Competition" (Org2) can see. Switch your identity:

```bash
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=localhost:9051
```{{exec}}

### 5. Attempt Query as Org2
Try to read the private data as Org2. 

`peer chaincode query -C mychannel -n private -c '{"Args":["ReadAssetPrivateData","assetCollection","asset1"]}'`{{exec}}

**The Result:** You will likely see an error or empty data for the sensitive fields. Even though Org2 is on the same channel, they were not authorized by the `collections_config.json` to see this specific data!

Congratulations! You have mastered the fundamentals of Hyperledger Fabric.
