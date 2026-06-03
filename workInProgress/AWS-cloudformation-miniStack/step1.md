# Initial setup

we'll be using Ministack, an AWS emulator

- try the website for documentation and AWS101 https://ministack.org/

to view docker-compose

`cat docker-compose.yml`{{exec}}

Lets startup the Ministack  
`docker-compose up -d`{{exec}}



When ready, open another cli tab and install the tools we'll be using




## Install AWS CLI 

`curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"`{{exec}}

`unzip awscliv2.zip`{{exec}}

`sudo ./aws/install`{{exec}}

`rm -rf awscliv2.zip ./aws`{{exec}}

`aws --version`{{exec}}


### 2. Configure for MiniStack
Once installed, the CLI defaults to looking for real AWS servers. You need to "trick" it into looking at your local MiniStack container. You have two ways to do this:

**Option A: The "Dummy" Configuration (Recommended for Labs)**
Run `aws configure` and enter these values:
* **AWS Access Key ID**: `test`
* **AWS Secret Access Key**: `test`
* **Default region name**: `us-east-1`
* **Default output format**: `json`

**Option B: The "One-Liner" Export**
If you don't want to go through the interactive prompt, just run this:
```bash
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
```{{exec}}

### 3. Testing the Connection
Now that you have both MiniStack (from your Docker Compose) and the CLI ready, try to create your first bucket:

### Confirm ministack is up

`curl http://localhost:4566/_ministack/health | jq`{{exec}}

We could use the AWS command directly to interact with ministact on port 4566,

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://my-first-bucket
```{{exec}}

instead  lets make an alias:

`alias awslocal='aws --endpoint-url=http://localhost:4566'`{{exec}}

```bash
awslocal s3 mb s3://my-first-bucket
```{{exec}}

```bash
awslocal s3 mb ls
```{{exec}}




# optional

This `docker-compose.yml` is optimized for **MiniStack** (2026 version) and is specifically designed to work in restricted environments like **Killercoda**.

It includes persistence (so you don't lose data on restarts), Lambda support, and a pre-configured "Init" volume for your setup scripts.

### The Docker Compose File

```yaml
services:
  ministack:
    image: ministackorg/ministack:latest
    container_name: ministack_main
    ports:
      - "4566:4566"            # The single entry point for all 45+ services
    environment:
      - LOG_LEVEL=INFO         # Options: DEBUG, INFO, WARNING, ERROR
      - PERSIST_STATE=1        # Saves metadata (Buckets, Queues, etc.)
      - S3_PERSIST=1           # Saves actual S3 file content
      - LAMBDA_EXECUTOR=docker # Runs Lambdas in real containers
      - DOCKER_NETWORK=lab_net # Important for Lambda-to-Service communication
      - MINISTACK_REGION=us-east-1
    volumes:
      # Allows MiniStack to spin up Lambda/RDS sidecar containers
      - /var/run/docker.sock:/var/run/docker.sock
      # Persistent storage for your data
      - ./ministack_data:/tmp/ministack
      # Setup scripts (runs automatically on startup)
      - ./init-scripts:/etc/localstack/init/ready.d
    networks:
      - lab_net

networks:
  lab_net:
    driver: bridge
```

---

### How to use this for your Lab

#### 1. Automated Setup (Housekeeping)
Create a folder named `init-scripts` in the same directory as your compose file. Any `.sh` or `.py` file you put there will execute as soon as MiniStack is ready. 

**Example `init-scripts/setup.sh`:**
```bash
#!/bin/bash
echo "Creating initial lab resources..."
aws --endpoint-url=http://localhost:4566 s3 mb s3://lab-data
aws --endpoint-url=http://localhost:4566 secretsmanager create-secret --name db-password --secret-string "KeepItSecret123"
```

#### 2. Killercoda specific tip
In browser-based labs, you often need to set the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` to dummy values in your terminal so the AWS CLI doesn't throw a "credentials not found" error:
```bash
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
```



### Pro-Tip: Memory Limits
If Killercoda feels sluggish, you can add a resource limit to the `ministack` service block:
```yaml
    deploy:
      resources:
        limits:
          memory: 512M
```
*(MiniStack only needs about 30-50MB, but 512MB gives it breathing room to spin up those "real" RDS or Lambda containers without hitting the VM's ceiling.)*