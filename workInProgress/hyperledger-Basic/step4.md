# Step 4: Deploying Private Data Collections

Sometimes, organizations on the same channel need to keep data private from each other (e.g., a secret price between a buyer and seller). **Private Data Collections (PDC)** allow you to do this without the overhead of creating new channels.

### 1. Understanding the Collection Config
Private data is governed by a JSON configuration file. This file defines which organizations have "Read" access to the private data. 

Let's look at the configuration for our next deployment:

`cat ../asset-transfer-private-data/chaincode-go/collections_config.json`{{exec}}

Notice how `assetCollection` is defined to allow members from both Org1 and Org2, while other collections might be restricted to just one.

### 2. Clean up the Previous Chaincode
To avoid conflicts, we will bring the network down and back up to start fresh for this advanced feature.

`./network.sh down`{{exec}}

`./network.sh up createChannel`{{exec}}

### 3. Deploy Chaincode with PDC
We will now deploy the `asset-transfer-private-data` chaincode. Notice the additional `-collections-config` flag.

`./network.sh deployCC -ccn private -ccp ../asset-transfer-private-data/chaincode-go/ -ccl go -cccg ../asset-transfer-private-data/chaincode-go/collections_config.json`{{exec}}

This command tells the peers exactly who is allowed to store and see the private data associated with this contract.

### 4. Verify the Deployment
Check that the `private` chaincode containers are now running.

`docker ps --filter name=private`{{exec}}

Now that privacy is configured at the protocol level, let's test it in the final step!
