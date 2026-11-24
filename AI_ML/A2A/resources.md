# A2A Lab Resources

## Protocol & SDK

- A2A Protocol Spec v1.0: https://a2a-protocol.org/latest/specification/
- A2A Python SDK (a2a-sdk): https://github.com/a2aproject/a2a-python
- A2A Samples: https://github.com/a2aproject/a2a-samples
- A2A Python Tutorial: https://a2a-protocol.org/latest/tutorials/python/1-introduction/

## opencode

- opencode: https://opencode.ai
- opencode-a2a: https://github.com/Intelligent-Internet/opencode-a2a
- opencode-a2a PyPI: https://pypi.org/project/opencode-a2a/

## Key Concepts

- Agent Card: `/.well-known/agent-card.json` — describes agent capabilities
- JSON-RPC methods: `message/send`, `tasks/get`, `tasks/cancel`
- Task states: `TASK_STATE_WORKING`, `TASK_STATE_COMPLETED`, `TASK_STATE_FAILED`, `TASK_STATE_CANCELED`
- Event queue: Agents publish events back to the client via `EventQueue`

## Useful Commands

```bash
# Verify A2A SDK installation
python -c "import a2a; print('A2A SDK imported successfully')"

# Fetch an Agent Card
curl -s http://127.0.0.1:9000/.well-known/agent-card.json | python -m json.tool

# Send a JSON-RPC message via curl
curl -s -X POST http://127.0.0.1:9000/ \
  -H "Content-Type: application/json" \
  -H "A2A-Version: 1.0" \
  -d '{"jsonrpc":"2.0","id":1,"method":"message/send","params":{"message":{"role":"ROLE_USER","parts":[{"text":"Convert 100 USD to EUR"}],"messageId":"test-001"}}}'

# Check task state via JSON-RPC
curl -s -X POST http://127.0.0.1:9000/ \
  -H "Content-Type: application/json" \
  -H "A2A-Version: 1.0" \
  -d '{"jsonrpc":"2.0","id":2,"method":"tasks/get","params":{"id":"TASK_ID_HERE"}}'
```
