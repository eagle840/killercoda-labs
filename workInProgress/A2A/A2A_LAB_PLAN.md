# A2A (Agent-to-Agent) Protocol Lab — Build Plan

## Overview

Build a Killercoda scenario that teaches the A2A protocol by having the learner build two deterministic Python A2A agents, connect them via the protocol, then wire up opencode as an AI-powered A2A client.

**Hook:** Google doesn't have a working A2A lab. This complements the existing MCP lab (MCP = agent-to-tool, A2A = agent-to-agent).

**Target location:** `AI_ML/A2A/` (or `workInProgress/A2A/`)

## Scenario

**Currency Converter + Tax Calculator:**

- **Agent A — Currency Converter** (port 9000): Receives an amount and source/target currency, returns the converted amount. Deterministic logic (hardcoded exchange rates).
- **Agent B — Tax Calculator** (port 9001): Receives an amount and a tax rate, returns the tax amount and total. Deterministic logic.
- **Orchestrator Client**: Sends a request like "Convert 100 USD to EUR and calculate 20% VAT" — discovers both agents via Agent Cards, delegates the currency conversion to Agent A, then the tax calculation to Agent B.
- **opencode via opencode-a2a** (port 8000): opencode becomes an A2A client. The learner uses `opencode-a2a call` to send a natural language request that triggers both agents.

## Environment

- **Backend:** `ubuntu-4GB` (need 4GB for opencode + opencode-a2a + 2 Python agents)
- **Multiple terminal tabs** (at least 4: Agent A, Agent B, opencode-a2a, client/CLI)
- **UI layout:** terminal (same as MCP lab)
- **Install during scenario:**
  - `uv` (Python package manager) — `curl -LsSf https://astral.sh/uv/install.sh | sh`
  - `a2a-sdk` — `uv pip install "a2a-sdk[http-server]" uvicorn`
  - `opencode` — `curl -fsSL https://opencode.ai/install | bash`
  - `opencode-a2a` — `uv tool install opencode-a2a`
- **Pre-installed:** Python 3.10+, pip

## Tech Stack

| Component | What | Version |
|-----------|------|---------|
| Python A2A SDK | `a2a-sdk` | v1.0+ (latest) |
| A2A Protocol | JSON-RPC over HTTP | v1.0 |
| opencode | AI agent runtime | latest |
| opencode-a2a | A2A adapter for opencode | latest (A2A v1.0) |
| Backend | ubuntu-4GB Killercoda image | — |

## Lab Steps (8 steps)

### Step 1: Setup Environment
**Goal:** Install all dependencies, start opencode early so model downloads in background.

**Actions:**
1. Install `uv`: `curl -LsSf https://astral.sh/uv/install.sh | sh && source $HOME/.local/bin/env`
2. Install opencode: `curl -fsSL https://opencode.ai/install | bash`
3. Start `opencode` in a separate tab — let it initialize and download the free model (select free model if prompted, then exit)
4. Create project directory: `mkdir -p ~/a2a-lab && cd ~/a2a-lab`
5. Create Python venv: `uv venv && source .venv/bin/activate`
6. Install A2A SDK: `uv pip install "a2a-sdk[http-server]" uvicorn`
7. Verify: `python -c "import a2a; print(a2a.__version__)"`

**Verify:** All installs complete without errors.

### Step 2: Build Currency Converter Agent
**Goal:** Build the first A2A server — a Currency Converter agent.

**Files to create:**
- `agent_a_card.py` — Agent Card and Skill definition
- `agent_a_executor.py` — AgentExecutor with currency conversion logic
- `agent_a_server.py` — Starlette server with A2A routes

**Key code patterns (from official a2a-sdk v1.0):**

Agent Card:
```python
from a2a.types import AgentCapabilities, AgentCard, AgentInterface, AgentSkill

skill = AgentSkill(
    id='currency_converter',
    name='Currency Converter',
    description='Converts amounts between currencies using hardcoded exchange rates.',
    input_modes=['text/plain'],
    output_modes=['text/plain'],
    tags=['a2a', 'currency', 'conversion'],
    examples=['Convert 100 USD to EUR', 'How much is 50 GBP in JPY'],
)

agent_card = AgentCard(
    name='Currency Converter Agent',
    description='Converts currency amounts using fixed exchange rates.',
    version='0.0.1',
    default_input_modes=['text/plain'],
    default_output_modes=['text/plain'],
    capabilities=AgentCapabilities(streaming=False),
    supported_interfaces=[
        AgentInterface(
            protocol_binding='JSONRPC',
            url='http://127.0.0.1:9000',
            protocol_version='1.0',
        )
    ],
    skills=[skill],
)
```

Agent Executor:
```python
from a2a.server.agent_execution import AgentExecutor, RequestContext
from a2a.server.events import EventQueue
from a2a.types import Task, TaskStatus, TaskState
from a2a.utils.message import new_agent_text_message

RATES = {
    ('USD', 'EUR'): 0.92, ('EUR', 'USD'): 1.09,
    ('USD', 'GBP'): 0.79, ('GBP', 'USD'): 1.27,
    ('USD', 'JPY'): 149.5, ('JPY', 'USD'): 0.00669,
    ('EUR', 'GBP'): 0.86, ('GBP', 'EUR'): 1.16,
    # ... add more as needed
}

class CurrencyConverterExecutor(AgentExecutor):
    async def execute(self, context: RequestContext, event_queue: EventQueue):
        user_text = context.message.parts[0].root.text
        # Parse "Convert X FROM_CURRENCY to TO_CURRENCY"
        # Look up rate, compute result
        result = f"{amount} {from_curr} = {converted:.2f} {to_curr}"
        await event_queue.put(Task(
            id=context.task_id,
            context_id=context.context_id,
            status=TaskStatus(
                state=TaskState.completed,
                message=new_agent_text_message(result, context.context_id, context.task_id),
            ),
        ))

    async def cancel(self, context: RequestContext, event_queue: EventQueue):
        pass
```

Server:
```python
import uvicorn
from a2a.server.request_handlers import DefaultRequestHandler
from a2a.server.routes import create_agent_card_routes, create_jsonrpc_routes
from a2a.server.tasks import InMemoryTaskStore
from starlette.applications import Starlette
from agent_a_executor import CurrencyConverterExecutor
from agent_a_card import agent_card

request_handler = DefaultRequestHandler(
    agent_executor=CurrencyConverterExecutor(),
    task_store=InMemoryTaskStore(),
    agent_card=agent_card,
)

routes = []
routes.extend(create_agent_card_routes(agent_card))
routes.extend(create_jsonrpc_routes(request_handler, '/'))
app = Starlette(routes=routes)

if __name__ == '__main__':
    uvicorn.run(app, host='127.0.0.1', port=9000)
```

**Start it:** `python agent_a_server.py`

**Verify:** `curl http://127.0.0.1:9000/.well-known/agent-card.json` returns the Agent Card JSON.

### Step 3: Test with curl
**Goal:** Send raw JSON-RPC messages to the Currency Converter and see the protocol in action.

**Actions:**
1. Fetch the Agent Card:
   ```
   curl -s http://127.0.0.1:9000/.well-known/agent-card.json | python -m json.tool
   ```
2. Send a message via JSON-RPC:
   ```
   curl -s -X POST http://127.0.0.1:9000/ \
     -H "Content-Type: application/json" \
     -H "A2A-Version: 1.0" \
     -d '{
       "jsonrpc": "2.0",
       "id": 1,
       "method": "SendMessage",
       "params": {
         "message": {
           "role": "ROLE_USER",
           "parts": [{"text": "Convert 100 USD to EUR"}],
           "messageId": "test-001"
         }
       }
     }'
   ```
3. Check terminal output — server should print the incoming request details.

**Verify:** Response contains `"state": "TASK_STATE_COMPLETED"` with the converted amount.

### Step 4: Build Tax Calculator Agent
**Goal:** Build the second A2A server — same pattern, different logic, port 9001.

**Files to create:**
- `agent_b_card.py`
- `agent_b_executor.py`
- `agent_b_server.py`

**Tax Calculator logic:**
- Parses "Calculate X% tax on AMOUNT" or similar
- Returns: tax amount, total with tax
- Example: "20% tax on 100" → "Tax: 20.00, Total: 120.00"

**Start it:** `python agent_b_server.py` (in a new terminal tab, port 9001)

**Verify:** `curl http://127.0.0.1:9001/.well-known/agent-card.json`

### Step 5: Build Orchestrator Client
**Goal:** A Python client that discovers both agents and delegates tasks.

**File:** `orchestrator.py`

**Logic:**
1. Fetch Agent Card from Agent A (Currency Converter)
2. Fetch Agent Card from Agent B (Tax Calculator)
3. Send "Convert 100 USD to EUR" to Agent A → get converted amount
4. Take the result, send "Calculate 20% tax on {converted_amount}" to Agent B
5. Print the full pipeline result

**Key client code pattern (a2a-sdk v1.0):**
```python
import asyncio
import httpx
from a2a.client import A2ACardResolver, A2AClient
from a2a.types import SendMessageRequest, MessageSendParams
from uuid import uuid4

async def call_agent(base_url: str, message: str):
    async with httpx.AsyncClient() as httpx_client:
        resolver = A2ACardResolver(httpx_client=httpx_client, base_url=base_url)
        card = await resolver.get_agent_card()
        client = A2AClient(httpx_client=httpx_client, agent_card=card)
        request = SendMessageRequest(
            id=str(uuid4()),
            params=MessageSendParams(
                message={
                    'role': 'user',
                    'parts': [{'kind': 'text', 'text': message}],
                    'messageId': uuid4().hex,
                }
            )
        )
        response = await client.send_message(request)
        return response.result

async def main():
    # Step 1: Convert currency
    conversion = await call_agent('http://127.0.0.1:9000', 'Convert 100 USD to EUR')
    print(f'Conversion result: {conversion}')

    # Step 2: Calculate tax on the result
    # Parse the converted amount from the response
    tax = await call_agent('http://127.0.0.1:9001', f'Calculate 20% tax on {converted_amount}')
    print(f'Tax result: {tax}')

asyncio.run(main())
```

**Verify:** Running `python orchestrator.py` shows both agents responding in sequence.

### Step 6: Debug
**Goal:** Teach the learner how to inspect and debug A2A communication.

**Debugging techniques to cover:**
1. **Agent Card inspection:** `curl` the `/.well-known/agent-card.json` endpoint — verify skills, endpoints, capabilities
2. **Raw JSON-RPC:** Send malformed requests and observe error responses
3. **Server terminal output:** Show that the Python servers print incoming request details to stdout
4. **Task state inspection:** Use `tasks/get` JSON-RPC method to check task status
5. **Common issues to demonstrate:**
   - Agent Card URL mismatch (card says port 9000, server on 9001)
   - Missing `A2A-Version: 1.0` header
   - Malformed message parts (missing `role`, missing `parts`)

### Step 7: Wire Up opencode via opencode-a2a
**Goal:** Install opencode-a2a, configure it as an A2A client, connect to the Python agents.

**Actions:**
1. Install opencode-a2a: `uv tool install opencode-a2a`
2. Make sure opencode is running: `opencode serve --hostname 127.0.0.1 --port 4096`
3. Start opencode-a2a:
   ```bash
   A2A_HOST=127.0.0.1 \
   A2A_PORT=8000 \
   A2A_PUBLIC_URL=http://127.0.0.1:8000 \
   OPENCODE_BASE_URL=http://127.0.0.1:4096 \
   A2A_TASK_STORE_DATABASE_URL=sqlite+aiosqlite:///./opencode-a2a.db \
   OPENCODE_WORKSPACE_ROOT=$HOME/a2a-lab \
   opencode-a2a serve
   ```
4. Verify: `curl http://127.0.0.1:8000/.well-known/agent-card.json`

**Verify:** opencode-a2a is running and its Agent Card is accessible.

### Step 8: Final Demo
**Goal:** Use `opencode-a2a call` to send a natural language request that triggers both agents.

**Actions:**
1. Call the Currency Converter via opencode-a2a:
   ```bash
   opencode-a2a call http://127.0.0.1:9000/.well-known/agent-card.json "Convert 100 USD to EUR"
   ```
2. Call the Tax Calculator via opencode-a2a:
   ```bash
   opencode-a2a call http://127.0.0.1:9001/.well-known/agent-card.json "Calculate 20% tax on 92.00"
   ```
3. Show the full flow working end-to-end

**Verify:** Both calls return correct results via opencode's LLM.

## Scenario Files

The scenario directory should contain:
```
AI_ML/A2A/
├── index.json          # Killercoda scenario metadata
├── intro.md            # Introduction — what is A2A, what you'll build
├── plan.md             # This file (internal reference, not shown to learner)
├── resources.md        # Links to A2A spec, SDK docs, opencode-a2a
├── finish.md           # Wrap-up — what you learned, next steps
├── step1.md            # Setup environment
├── step2.md            # Build Currency Converter agent
├── step3.md            # Test with curl
├── step4.md            # Build Tax Calculator agent
├── step5.md            # Build orchestrator client
├── step6.md            # Debug
├── step7.md            # Wire up opencode-a2a
├── step8.md            # Final demo
└── assets/
    └── starter/        # Template files the learner copies (optional)
```

## index.json Template

```json
{
  "title": "Agent-to-Agent (A2A) Protocol Lab",
  "description": "Build two A2A agents in Python, connect them via the protocol, then integrate with opencode.",
  "difficulty": "Intermediate",
  "time": "60",
  "details": {
    "assets": {
      "host01": []
    },
    "steps": [
      { "title": "Setup Environment", "text": "step1.md" },
      { "title": "Build Currency Converter Agent", "text": "step2.md" },
      { "title": "Test with curl", "text": "step3.md" },
      { "title": "Build Tax Calculator Agent", "text": "step4.md" },
      { "title": "Build Orchestrator Client", "text": "step5.md" },
      { "title": "Debug A2A Communication", "text": "step6.md" },
      { "title": "Wire Up opencode via A2A", "text": "step7.md" },
      { "title": "Final Demo", "text": "step8.md" }
    ],
    "intro": { "text": "intro.md" },
    "finish": { "text": "finish.md" }
  },
  "environment": {
    "uilayout": "terminal"
  },
  "backend": {
    "imageid": "ubuntu-4GB"
  }
}
```

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| opencode first-run model download eats session time | High | Start opencode in step 1, let it download while learner writes agent code |
| opencode-a2a is third-party (not Google-official) | Medium | Pin version, have fallback to raw Python client if it breaks |
| 4 processes on 4GB RAM | Medium | Close unused tabs, keep agents simple |
| a2a-sdk API changes between versions | Medium | Pin `a2a-sdk` version in install command |
| Killercoda session timeout (1 hour) | High | Keep steps tight, pre-create asset files for agent code |

## Key References

- A2A Protocol Spec: https://a2a-protocol.org/latest/specification/
- A2A Python SDK: https://github.com/a2aproject/a2a-python
- A2A Samples: https://github.com/a2aproject/a2a-samples
- A2A Python Tutorial: https://a2a-protocol.org/latest/tutorials/python/1-introduction/
- opencode-a2a: https://github.com/Intelligent-Internet/opencode-a2a
- opencode: https://opencode.ai
