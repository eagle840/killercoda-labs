# Step 2: Setup Inference & MCP Environment

Now we will install Ollama, set up the MCP SDK, and install the MCP Inspector for debugging.

### 1. Install Ollama
Run the official installation script:

`curl -fsSL https://ollama.com/install.sh | sh`{{exec}}

### 2. Verify the Installation
Check if the service is running:

`systemctl status ollama`{{exec}}

*(Press `q` to exit the status view).*

### 3. Run the Model
Pull and run the **Qwen 2.5 0.5B** model (recommended for basic tool use):

`ollama pull qwen2.5:0.5b`{{exec}}

### 4. Install MCP Tools
Create and activate a virtual environment for your MCP tools:

`mkdir mcp_env; cd mcp_env`{{exec}}
`python3 -m venv .venv`{{exec}}
`source .venv/bin/activate`{{exec}}

Install the MCP SDK and the MCP Inspector:

`pip install mcp`{{exec}}
`pip install @modelcontextprotocol/inspector`{{exec}}
