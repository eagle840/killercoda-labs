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