# Congratulations!

You have completed the **Agent-to-Agent (A2A) Protocol Lab**.

### What you've learned

- **A2A Agent Cards** describe an agent's name, skills, capabilities, and endpoint — enabling automatic discovery
- **JSON-RPC messaging** is the transport for sending messages and managing tasks between agents
- **AgentExecutor** is the core interface for building A2A servers — implement `execute()` and `cancel()` to handle requests
- **Task lifecycle** flows through states: working → completed (or failed/canceled)
- **Orchestrator clients** can chain multiple agents by fetching their Agent Cards, delegating tasks, and passing results between them
- **opencode-a2a** bridges an AI runtime into the A2A ecosystem, turning opencode into both an A2A server and client

### Next Steps

- Read the full **A2A Protocol specification**: https://a2a-protocol.org/latest/specification/
- Explore the **A2A Python SDK** source and examples: https://github.com/a2aproject/a2a-python
- Browse **A2A sample agents**: https://github.com/a2aproject/a2a-samples
- Check out **opencode-a2a**: https://github.com/Intelligent-Internet/opencode-a2a
- Try adding **streaming** support to your agents (A2A supports SSE-based streaming)
- Build agents in different languages — A2A is protocol-agnostic

Well done!
