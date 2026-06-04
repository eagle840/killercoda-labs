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
awslocal s3 ls
```{{exec}}


