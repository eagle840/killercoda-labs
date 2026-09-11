# Test with curl

Before building more agents, let's understand the A2A protocol by sending raw **JSON-RPC** messages to the Currency Converter with `curl`. This gives you a feel for the wire format and how agents communicate.


**Note:** Make sure the Currency Converter agent is still running in the other terminal tab on port 9000.

## 1. Fetch the Agent Card

The Agent Card is the discovery document — every A2A client fetches this first to learn what the agent can do.

```bash
curl -s http://127.0.0.1:9000/.well-known/agent-card.json | python -m json.tool
```{{exec}}

Look for:
- **`name`** — the agent's display name
- **`skills`** — what this agent can do (currency conversion)
- **`supported_interfaces`** — the endpoint URL and protocol binding

## 2. Send a Conversion Request

Now send a `message/send` JSON-RPC request directly:

```bash
curl -s -X POST http://127.0.0.1:9000/ \
  -H "Content-Type: application/json" \
  -H "A2A-Version: 1.0" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "message/send",
    "params": {
      "message": {
        "role": "ROLE_USER",
        "parts": [{"text": "Convert 100 USD to EUR"}],
        "messageId": "test-001"
      }
    }
  }' | python -m json.tool
```{{exec}}

**Note:** The key fields in the JSON-RPC request:
- **`method`**: `"message/send"` — tells the server to process a message
- **`message.role`**: `"ROLE_USER"` — the sender is a user
- **`message.parts`**: array of content parts (here, just text)
- **`message.messageId`**: a unique identifier for this message

## 3. Check the Server Output

Look at the Currency Converter's terminal tab — you should see the server print details about the incoming request. The agent processes the text, extracts the currencies and amount, and sends back a response.

## 4. Try Different Currencies

Send another request with different currencies:

```bash
curl -s -X POST http://127.0.0.1:9000/ \
  -H "Content-Type: application/json" \
  -H "A2A-Version: 1.0" \
  -d '{
    "jsonrpc": "2.0",
    "id": 2,
    "method": "message/send",
    "params": {
      "message": {
        "role": "ROLE_USER",
        "parts": [{"text": "Convert 50 GBP to JPY"}],
        "messageId": "test-002"
      }
    }
  }' | python -m json.tool
```{{exec}}

The response should contain `50.00 GBP = 9462.00 JPY` (based on the hardcoded rate of 189.24).

## 5. Test an Invalid Request

Try sending a malformed request to see how the agent handles errors:

```bash
curl -s -X POST http://127.0.0.1:9000/ \
  -H "Content-Type: application/json" \
  -H "A2A-Version: 1.0" \
  -d '{
    "jsonrpc": "2.0",
    "id": 3,
    "method": "message/send",
    "params": {
      "message": {
        "role": "ROLE_USER",
        "parts": [{"text": "Hello world"}],
        "messageId": "test-003"
      }
    }
  }' | python -m json.tool
```{{exec}}

The agent should return a helpful error message explaining how to format the request.

## 6. Try Without the A2A Header

```bash
curl -s -X POST http://127.0.0.1:9000/ \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 4,
    "method": "message/send",
    "params": {
      "message": {
        "role": "ROLE_USER",
        "parts": [{"text": "Convert 100 USD to EUR"}],
        "messageId": "test-004"
      }
    }
  }' | python -m json.tool
```{{exec}}

**Note:** Observe whether the server still responds without the `A2A-Version` header. This demonstrates how the protocol validates incoming requests.

Click **Continue** once you understand the JSON-RPC message format.
