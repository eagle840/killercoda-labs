# Agent-to-Agent (A2A) Protocol Lab

**A2A (Agent-to-Agent)** is a protocol that lets AI agents discover and communicate with each other over HTTP. Think of it as the agent-to-agent counterpart to **MCP** (Model Context Protocol), which connects agents to tools.

In this lab you will:

1. **Install** the A2A Python SDK and supporting tools
2. **Build** two deterministic A2A agents in Python — a Currency Converter and a Tax Calculator
3. **Test** the agents with raw `curl` JSON-RPC calls to understand the protocol
4. **Build** a Python orchestrator client that chains both agents together
5. **Debug** A2A communication by inspecting Agent Cards and task states
6. **Integrate** opencode as an AI-powered A2A client using `opencode-a2a`

By the end you will understand how A2A discovery, messaging, and task lifecycle work — and how to wire real AI runtimes into the protocol.

### What you will learn

- A2A Agent Cards, Skills, and capabilities
- JSON-RPC messaging over HTTP (A2A v1.0)
- Building A2A servers with the `a2a-sdk` Python library
- Task state management (working, completed, failed)
- Agent discovery and delegation via an orchestrator client
- Connecting opencode to A2A agents

Let's get started!
