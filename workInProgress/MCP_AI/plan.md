# Lab Transformation Plan: MCP-Enabled AI Agent

## Objective
Transition the current lab from a direct-API integration (boto3 -> Ollama) to a standards-compliant **Model Context Protocol (MCP)** architecture.

## Proposed Changes

### 1. Architectural Shift
- **Old:** Python script calls `boto3` for AWS S3 and `ollama` library directly.
- **New:** 
  - Define an **S3 MCP Server** (exposing AWS S3 capabilities via MCP).
  - Define/Implement an **MCP Client/Agent** (using `mcp` Python SDK) that uses the LLM (via Ollama) to reason and call tools via the S3 MCP server.
  - Utilize **MCP Inspector** to visualize and debug the communication between the Client and the S3 MCP Server.

### 2. Modified Steps
- **Step 1: Setup Infrastructure** 
  - Keep MiniStack setup (S3).
- **Step 2: Setup Inference & MCP Environment**
  - Keep Ollama setup.
  - Install MCP Python SDK (`mcp` package) and MCP Inspector.
- **Step 3: Develop & Inspect MCP Components**
  - Implement a basic S3 MCP Server.
  - Use **MCP Inspector** to test the S3 MCP Server tools independently.
  - Update `agent.py` to act as an MCP Client.
- **Step 4: Orchestrate & Validate**
  - Run the MCP Client to perform the file organization task, demonstrating tool-use via MCP.

## Next Steps
1. User feedback on the proposed architecture.
2. Draft the modified Markdown steps.
3. Validate MCP server/client implementation locally.
