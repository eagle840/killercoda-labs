# Final Demo

Use `opencode-a2a call` to send natural language requests to both Python agents through the AI-powered A2A client. This is the culmination of the lab — the LLM inside opencode understands your request, discovers the target agent, and calls it via the A2A protocol.

**Note:** All four services should still be running.

## 1. Call the Currency Converter via opencode-a2a

```bash
opencode-a2a call http://127.0.0.1:9000/.well-known/agent-card.json "Convert 100 USD to EUR"
```{{exec}}

opencode-a2a will:
1. Fetch the Agent Card from port 9000
2. Use the LLM to understand your natural language request
3. Send the formatted message to the Currency Converter
4. Return the result

## 2. Call the Tax Calculator via opencode-a2a

```bash
opencode-a2a call http://127.0.0.1:9001/.well-known/agent-card.json "Calculate 20% tax on 92.00"
```{{exec}}

## 3. Try More Requests

Experiment with different requests:

```bash
opencode-a2a call http://127.0.0.1:9000/.well-known/agent-card.json "How much is 50 GBP in JPY?"
```{{exec}}

```bash
opencode-a2a call http://127.0.0.1:9001/.well-known/agent-card.json "What is 15% VAT on 250.50?"
```{{exec}}

## 4. Compare: Manual curl vs opencode-a2a

Notice the difference:
- **curl** (Step 3): You had to construct the exact JSON-RPC message with the correct protocol format
- **opencode-a2a**: You just write natural language, and the LLM handles the protocol details

This is the power of A2A — the protocol standardizes how agents communicate, and AI runtimes like opencode can plug in seamlessly.

## 5. Observe the Full Architecture

```
┌──────────────────────────────────────────────────┐
│                  You (Human)                      │
│          "Convert 100 USD to EUR"                 │
└──────────────┬───────────────────────────────────┘
               │  natural language
               ▼
┌──────────────────────────┐
│   opencode-a2a (:8000)   │  ← A2A Client
│   (LLM-powered)          │
└──────────────┬───────────┘
               │  JSON-RPC over HTTP
               ▼
┌──────────────────────────┐
│ Currency Converter (:9000)│  ← A2A Server
│ (deterministic logic)     │
└──────────────────────────┘
```

The same pattern applies when chaining agents — an orchestrator (human or AI) discovers agents, sends requests, and passes results between them.

Click **Continue** to wrap up the lab.
