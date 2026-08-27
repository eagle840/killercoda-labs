# Using MCP and Opencode


# Install uv Python Package manager

`curl -LsSf https://astral.sh/uv/install.sh | sh`{{exec}}

`source $HOME/.local/bin/env`{{exec}}

taken from: https://modelcontextprotocol.info/docs/quickstart/server/

# Install Opencode

`curl -fsSL https://opencode.ai/install | bash`{{exec}}

`shell bash`{{exec}}

(select a free model)

## Setup Node/MCP 

### Install node/npm and MCP inspector

`curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -`{{exec}}

`apt install nodejs -y`{{exec}}


`npm install @modelcontextprotocol/inspector`{{exec}}

`npm install @modelcontextprotocol/server-filesystem`{{exec}}

`npm install @modelcontextprotocol/server-memory`{{exec}}

for a full list of servers see https://github.com/modelcontextprotocol/servers

## Config Opencode for MCP



To setup MCP Servers:  https://opencode.ai/docs/mcp-servers/



`mkdir  ~/.config/opencode/`{{exec}}           

`touch ~/.config/opencode/opencode.json`{{exec}}




Typical settings file (USE THIS)

We'll use the premade mcp server [fileserver](https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem)

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "my-filesystem-server": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-filesystem", "/"],
      "enabled": true
    },
    "memory": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-memory"],
      "enabled": true
    }
  }
}
```{{copy}}



Start Openocode

`opencode`{{exec}}

use `/models` to select one of the free llms

use `/mcps` to confirm your mcp is up

try `tell me the number of folders in the root`{{copy}}





# AWS Setup

we'll be using Ministack, an AWS emulator

- try the website for documentation and AWS101 https://ministack.org/

to view docker-compose

`cat docker-compose.yml`{{exec}}

Lets startup the Ministack  
`docker-compose up -d`{{exec}}



When ready, open another cli tab and install the tools we'll be using


## Install AWS CLI & Tools

`sudo apt update && sudo apt install -y zip jq`{{exec}}

`curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"`{{exec}}

`unzip awscliv2.zip`{{exec}}

`sudo ./aws/install`{{exec}}

`rm -rf awscliv2.zip ./aws`{{exec}}

`aws --version`{{exec}}

---

### Networking Note
MiniStack uses a dedicated Docker network called `lab_net` to allow the Lambda containers it spins up to communicate back to the main service. This is defined in your `docker-compose.yml`.



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

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://my-first-bucket
```{{exec}}

lets make an alias:

`alias awslocal='aws --endpoint-url=http://localhost:4566'`{{exec}}



### Pro-Tip: Memory Limits
If Killercoda feels sluggish, you can add a resource limit to the `ministack` service block:
```yaml
    deploy:
      resources:
        limits:
          memory: 512M
```
*(MiniStack only needs about 30-50MB, but 512MB gives it breathing room to spin up those "real" RDS or Lambda containers without hitting the VM's ceiling.)*