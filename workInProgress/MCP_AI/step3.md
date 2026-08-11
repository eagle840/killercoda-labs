# Step 3: Develop & Inspect MCP Components

In this step, we will implement an **S3 MCP Server** and use the **MCP Inspector** to verify that it works correctly.

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
