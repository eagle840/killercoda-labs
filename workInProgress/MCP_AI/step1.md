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

for a full list of servers see https://github.com/modelcontextprotocol/servers

## Config Opencode for MCP



To setup MCP Servers:  https://opencode.ai/docs/mcp-servers/



`mkdir  ~/.config/opencode/`{{exec}}           

`touch ~/.config/opencode/opencode.json`{{exec}}



## add memory

```json
"memory": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-memory"]
}
```{{copy}}

Typical settings file (USE THIS)

We'll use the premade mcp server [fileserver](https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem)

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "my-filesystem-server": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-filesystem", "/"],
      "enabled": true,
      "environment": {
        "MY_ENV_VAR": "value"
      }
    }
  }
}
```{{copy}}

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "memory": {
        "command": "npx",
        "args": ["-y", "@modelcontextprotocol/server-memory"]
    }
  }
}
```{{copy}}

Start Openocode

use `/models` to select one of the free llms

use `/mcps` to confirm your mcp is up

try `tell me the number of folders in the root`{{copy}}