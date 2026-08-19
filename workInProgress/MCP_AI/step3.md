# Step 3: Develop & Inspect MCP Components

In this step, we will implement an **S3 MCP Server** and use the **MCP Inspector** to verify that it works correctly.


### 1 mcp server sdk

https://github.com/modelcontextprotocol/python-sdk

`uv add "mcp[cli]"      # or: pip install "mcp[cli]"`{{exec}}

```bash
# Create a new directory for our project
uv init adder
cd adder

# Create virtual environment and activate it
uv venv
```{{exec}}

`source .venv/bin/activate`{{exec}}


```bash
# Install dependencies
uv add "mcp[cli]" httpx

# Create our server file
touch server.py
```{{exec}}
Add these to the top of your server.py:

```python
from mcp.server import MCPServer

mcp = MCPServer("Demo")


@mcp.tool()
def add(a: int, b: int) -> int:
    """Add two numbers."""
    return a + b


@mcp.resource("greeting://{name}")
def greeting(name: str) -> str:
    """Greet someone by name."""
    return f"Hello, {name}!"
```{{copy}}


### 2. Inspect the MCP Server
Use the MCP Inspector to interact with your server tools:

WIP: remove:  `npx @modelcontextprotocol/inspector python3 s3_server.py`{{copy}}

WIP: try: `npx @modelcontextprotocol/inspector uv run mcp dev server.py`{{copy}}


WIP: try `uv run mcp dev server.py`{{copy}} then run the mcpinspector

However for killacoda, use:

`ALLOWED_ORIGINS="*"  HOST=0.0.0.0 DANGEROUSLY_BIND_ALL_INTERFACES=true npx @modelcontextprotocol/inspector python3 s3_server.py`{{exec}}

This will launch a web interface where you can list objects and manually trigger the tag tool to verify it works.

{{TRAFFIC_HOST1_6274}}

---

WIP below is the aws/boto one




### 1. Create S3 MCP Server (`s3_server.py`)
This server will expose tools to `list_objects` and `tag_object`.

`uv add boto3`{{exec}}

`touch s3_server.py`{{exec}}

```python
# from mcp.server.fastmcp import FastMCP
from mcp.server import MCPServer
import boto3

# Initialize the FastMCP server
# mcp = FastMCP("S3-Server")
mcp = MCPServer("S3-Server")



# Setup MiniStack connection
s3 = boto3.client('s3', 
                  endpoint_url='http://localhost:4566',
                  aws_access_key_id='test',
                  aws_secret_access_key='test',
                  region_name='us-east-1')

# Define a tool to list objects in an S3 bucket
@mcp.tool()
def list_objects(bucket: str) -> str:
    """List objects in an S3 bucket"""
    response = s3.list_objects_v2(Bucket=bucket)
    return str(response.get('Contents', []))

# Define a tool to tag an S3 object
@mcp.tool()
def tag_object(bucket: str, key: str, category: str) -> str:
    """Tag an S3 object with a category"""
    s3.put_object_tagging(
        Bucket=bucket,
        Key=key,
        Tagging={'TagSet': [{'Key': 'Category', 'Value': category}]}
    )
    return f"Tagged {key} with {category}"

# Run the MCP server on 0.0.0.0
if __name__ == "__main__":
    mcp.run(transport="sse", host="0.0.0.0", port=8000)
```{{copy}}

### 2. Inspect the MCP Server
Use the MCP Inspector to interact with your server tools:

`npx @modelcontextprotocol/inspector python3 s3_server.py`{{copy}}

However for killacoda, use:

`ALLOWED_ORIGINS="*"  HOST=0.0.0.0 DANGEROUSLY_BIND_ALL_INTERFACES=true npx @modelcontextprotocol/inspector python3 s3_server.py`{{exec}}

This will launch a web interface where you can list objects and manually trigger the tag tool to verify it works.

{{TRAFFIC_HOST1_6274}}
