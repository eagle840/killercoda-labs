# Debug A2A Communication

Understanding how to inspect and debug A2A communication is critical when things go wrong. In this step you will practice several debugging techniques using the agents you built.

**Note:** Both agents should still be running in their terminal tabs.

## 1. Inspect Agent Cards

The Agent Card is your first source of truth. Fetch both:

```bash
curl -s http://127.0.0.1:9000/.well-known/agent-card.json | python -m json.tool
```{{exec}}

```bash
curl -s http://127.0.0.1:9001/.well-known/agent-card.json | python -m json.tool
```{{exec}}

For each, verify:
- **`name`** and **`description`** match expectations
- **`skills`** — the agent advertises the right capabilities
- **`supported_interfaces[0].url`** — the URL matches the port the agent is actually running on
- **`supported_interfaces[0].protocol_binding`** — should be `"JSONRPC"`

## 2. Check Task States

The A2A protocol tracks tasks through states. Send a message and then query the task state:

```bash
# Send a message and capture the task ID
RESPONSE=$(curl -s -X POST http://127.0.0.1:9000/ \
  -H "Content-Type: application/json" \
  -H "A2A-Version: 1.0" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "SendMessage",
    "params": {
      "message": {
        "role": "ROLE_USER",
        "parts": [{"text": "Convert 200 USD to GBP"}],
        "messageId": "debug-001"
      }
    }
  }')

echo "$RESPONSE" | python -m json.tool
```{{exec}}

Look for `"state": "TASK_STATE_COMPLETED"` in the response — this confirms the agent finished processing.

## 3. Test Malformed Messages

Deliberately send broken requests to see how errors are handled:

### Missing `role` field:

```bash
curl -s -X POST http://127.0.0.1:9000/ \
  -H "Content-Type: application/json" \
  -H "A2A-Version: 1.0" \
  -d '{
    "jsonrpc": "2.0",
    "id": 10,
    "method": "SendMessage",
    "params": {
      "message": {
        "parts": [{"text": "Convert 100 USD to EUR"}],
        "messageId": "bad-001"
      }
    }
  }' | python -m json.tool
```{{exec}}

### Empty `parts` array:

```bash
curl -s -X POST http://127.0.0.1:9000/ \
  -H "Content-Type: application/json" \
  -H "A2A-Version: 1.0" \
  -d '{
    "jsonrpc": "2.0",
    "id": 11,
    "method": "SendMessage",
    "params": {
      "message": {
        "role": "ROLE_USER",
        "parts": [],
        "messageId": "bad-002"
      }
    }
  }' | python -m json.tool
```{{exec}}

### Invalid JSON-RPC method:

```bash
curl -s -X POST http://127.0.0.1:9000/ \
  -H "Content-Type: application/json" \
  -H "A2A-Version: 1.0" \
  -d '{
    "jsonrpc": "2.0",
    "id": 12,
    "method": "invalid/method",
    "params": {}
  }' | python -m json.tool
```{{exec}}

**Note:** Observe the error codes and messages. A2A uses standard JSON-RPC error codes (-32600 for invalid request, -32601 for method not found, etc.).

## 4. Check Server Logs

Switch to the Currency Converter's terminal tab. Look at the server's stdout output — each incoming request is logged with details about the request body. This is invaluable for debugging.

## 5. Agent Card URL Mismatch

A common mistake is when the Agent Card advertises one port but the server runs on another. Verify consistency:

```bash
# Check what the card says
curl -s http://127.0.0.1:9000/.well-known/agent-card.json | python -c "
import sys, json
card = json.load(sys.stdin)
for iface in card.get('supported_interfaces', []):
    print(f\"Card endpoint: {iface['url']}\")
"
```{{exec}}

```bash
# Check what the server is actually on
ss -tlnp | grep -E '9000|9001'
```{{exec}}

Both should match. If they don't, update the `AgentCard` in the agent's card file.

Click **Continue** once you've explored the debugging techniques.
