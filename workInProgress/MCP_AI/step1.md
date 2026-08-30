# Using MCP and Opencode

WIP figure out where to put [MCP.so](mcp.so)


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


## Install a couple of simple, local MCPs

`npm install @modelcontextprotocol/server-filesystem`{{exec}}

`npm install @modelcontextprotocol/server-memory`{{exec}}

## MCP Servers Lists

for a full list of servers see 

- https://github.com/modelcontextprotocol/servers
- put [MCP.so](mcp.so)

# MCP Inspectors

`npm install @modelcontextprotocol/inspector`{{exec}}

`npm install @mcp-use/inspector`{{exec}}

# MCP-USE



### Running MCP Inspector for Public Access

The **MCP (Model Context Protocol) Inspector** is a developer tool used for testing and debugging MCP servers. By default, running it locally (`npx @modelcontextprotocol/inspector` or via `mcp-use`) binds it to `localhost`, making it accessible only to your machine.

If you want to run the MCP Inspector so that **anyone on the internet can use it**, you need to address two things: binding it to all network interfaces (or using a tunnel) and securing it, as the Inspector gives direct control over executing tools and server actions.

#### Step 1: Bind to All Interfaces / Host Externally

Most variants of the Inspector or its proxy can be configured via environment variables or CLI arguments to listen externally. For example, if you are running a custom setup or hosting the `@mcp-use/inspector` package:

* **Host/Port Configuration:** Ensure the host is set to `0.0.0.0` (all interfaces) rather than `127.0.0.1` so it accepts external traffic.
* *Example (if supported by your wrapper/proxy script):*
```bash
HOST=0.0.0.0 PORT=8080 npx @mcp-use/inspector

```



#### Step 2: Expose via a Secure Tunnel (Easiest & Safest Method)

Instead of opening raw firewall ports on a cloud server, the easiest way to let anyone access a local or private instance securely is to use a tunneling tool like **Cloudflare Tunnels** or **ngrok**:

1. Start your local MCP Inspector as you normally would:
```bash
npx @mcp-use/inspector

```


2. In a separate terminal window, expose the local port (e.g., `8080` or `6274`) using a tunnel:
```bash
cloudflared tunnel --url http://localhost:8080

```


3. Cloudflare will give you a public `https://*.trycloudflare.com` URL. Anyone you share this link with can access your inspector from their browser.

---

### ⚠️ Important Security Warning

The MCP Inspector is built as a **local debugging tool**. Exposing an unprotected Inspector to the public internet means **anyone** with the link can potentially run tools, query resources, and interact with the underlying connected servers.

If you choose to host it publicly:

* Put it behind a reverse proxy with **authentication** (like HTTP Basic Auth, OAuth, or Cloudflare Access).
* Avoid connecting it to production environments with sensitive data or destructive backend tools unless proper access controls are enforced.

Are you trying to deploy the inspector as part of a cloud learning environment (like a Killercoda scenario), or are you setting it up on a remote VPS?

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







