# Step 1: Setup Infrastructure

In this step, we will spin up our AWS emulator, MiniStack.

### 1. Start MiniStack
Run the Docker Compose configuration to start the services:

`docker-compose up -d`{{exec}}

### 2. Verify MiniStack is up
Check the health endpoint:

`curl http://localhost:4566/_ministack/health | jq`{{exec}}

### 3. Setup AWS CLI
Install the necessary tools:

`sudo apt update && sudo apt install -y zip jq`{{exec}}

`curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"`{{exec}}

`unzip awscliv2.zip`{{exec}}

`sudo ./aws/install`{{exec}}

`rm -rf awscliv2.zip ./aws`{{exec}}

`aws --version`{{exec}}

### 4. Configure for MiniStack
To ensure these settings persist across terminal sessions, append the credentials and alias to your `.bashrc`:

```bash
echo 'export AWS_ACCESS_KEY_ID=test' >> ~/.bashrc
echo 'export AWS_SECRET_ACCESS_KEY=test' >> ~/.bashrc
echo 'export AWS_DEFAULT_REGION=us-east-1' >> ~/.bashrc
echo "alias awslocal='aws --endpoint-url=http://localhost:4566'" >> ~/.bashrc
source ~/.bashrc
```{{exec}}

### 5. Create a test bucket
`awslocal s3 mb s3://file-organizer-bucket`{{exec}}
