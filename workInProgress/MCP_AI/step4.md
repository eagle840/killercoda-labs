# Step 4: Orchestrate Agent

Now we will create an MCP client that uses Ollama to intelligently categorize files in S3 by using our new MCP server tools.

### 1. Create the Agent Client (`agent_client.py`)
This script acts as the MCP client, querying the MCP server, and using Ollama to make decisions.

`uv add ollama`{{exec}}

`touch agent_client.py`{{exec}}

```python
import asyncio
from mcp import ClientSession, StdioServerParameters
from mcp.client.stdio import stdio_client
import ollama

async def run_agent():
    # Setup MCP Connection parameters to run the S3 server locally
    server_params = StdioServerParameters(command="python3", args=["s3_server.py"])
    
    # Start the MCP client session
    async with stdio_client(server_params) as (read, write):
        async with ClientSession(read, write) as session:
            # Initialize the session
            await session.initialize()

            # 1. List objects using the S3 MCP server tool
            tools = await session.list_tools()
            result = await session.call_tool("list_objects", arguments={"bucket": "file-organizer-bucket"})
            # Parse the result from the MCP tool
            files = eval(result.content[0].text)
            
            for file in files:
                filename = file['Key']
                # 2. Categorize the file using Ollama (LLM reasoning)
                prompt = f"Categorize {filename} as 'text', 'image', or 'other'. Reply ONLY with the category."
                response = ollama.chat(model='qwen2.5:0.5b', messages=[{'role': 'user', 'content': prompt}])
                category = response['message']['content'].strip()
                
                # 3. Tag the object using the S3 MCP server tool
                await session.call_tool("tag_object", arguments={
                    "bucket": "file-organizer-bucket",
                    "key": filename,
                    "category": category
                })
                print(f"File: {filename} -> Category: {category}")

# Run the async agent function
if __name__ == "__main__":
    asyncio.run(run_agent())
```{{copy}}

### 2. Run the Agent
Execute your MCP-powered agent:

`python3 agent_client.py`{{exec}}

### 3. Verify
Check tags again to confirm the automation worked:

`awslocal s3api get-object-tagging --bucket file-organizer-bucket --key test.txt`{{exec}}
`awslocal s3api get-object-tagging --bucket file-organizer-bucket --key photo.jpg`{{exec}}
