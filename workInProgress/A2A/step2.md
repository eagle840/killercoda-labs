# Build Currency Converter Agent

In this step you will build your first A2A server — a **Currency Converter** agent that listens on **port 9000**. It receives a currency conversion request, applies hardcoded exchange rates, and returns the result via the A2A protocol.

The agent consists of three files:

- **`agent_a_card.py`** — Agent Card and Skill definition
- **`agent_a_executor.py`** — AgentExecutor with the conversion logic
- **`agent_a_server.py`** — Starlette server with A2A routes

## 1. Create the Agent Card

The Agent Card is a JSON document served at `/.well-known/agent-card.json`. It describes your agent's name, description, skills, and endpoint so other agents can discover it.

```bash
cd ~/a2a-lab
touch agent_a_card.py
```{{exec}}

Open `agent_a_card.py` and add the following:

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
```{{copy}}

## 2. Create the Agent Executor

The `AgentExecutor` is where the agent's actual logic lives. You implement two methods: `execute()` for processing requests and `cancel()` for handling cancellation.

```bash
touch agent_a_executor.py
```{{exec}}

Add the following to `agent_a_executor.py`:

```python
import re
from a2a.helpers import (
    get_message_text,
    new_task_from_user_message,
    new_text_message,
    new_text_part,
)
from a2a.server.agent_execution import AgentExecutor, RequestContext
from a2a.server.events import EventQueue
from a2a.server.tasks import TaskUpdater
from a2a.types import TaskState


RATES = {
    ('USD', 'EUR'): 0.92,
    ('EUR', 'USD'): 1.09,
    ('USD', 'GBP'): 0.79,
    ('GBP', 'USD'): 1.27,
    ('USD', 'JPY'): 149.50,
    ('JPY', 'USD'): 0.00669,
    ('EUR', 'GBP'): 0.86,
    ('GBP', 'EUR'): 1.16,
    ('EUR', 'JPY'): 162.50,
    ('JPY', 'EUR'): 0.00615,
    ('GBP', 'JPY'): 189.24,
    ('JPY', 'GBP'): 0.00528,
}


def convert(amount: float, from_curr: str, to_curr: str) -> float:
    if from_curr == to_curr:
        return amount
    rate = RATES.get((from_curr, to_curr))
    if rate is None:
        raise ValueError(f'No exchange rate for {from_curr} -> {to_curr}')
    return round(amount * rate, 2)


def _convert_from_text(user_text: str) -> str:
    match = re.search(
        r'(\d+(?:\.\d+)?)\s+([A-Z]{3})\s+(?:to|in)\s+([A-Z]{3})',
        user_text,
        re.IGNORECASE,
    )
    if not match:
        return 'Could not parse request. Try: "Convert 100 USD to EUR"'
    amount = float(match.group(1))
    from_curr = match.group(2).upper()
    to_curr = match.group(3).upper()
    try:
        converted = convert(amount, from_curr, to_curr)
        return f'{amount:.2f} {from_curr} = {converted:.2f} {to_curr}'
    except ValueError as e:
        return str(e)


class CurrencyConverterExecutor(AgentExecutor):
    async def execute(self, context: RequestContext, event_queue: EventQueue):
        if context.current_task:
            task = context.current_task
        else:
            task = new_task_from_user_message(context.message)
            await event_queue.enqueue_event(task)

        task_updater = TaskUpdater(
            event_queue=event_queue, task_id=task.id, context_id=task.context_id
        )
        await task_updater.update_status(
            state=TaskState.TASK_STATE_WORKING,
            message=new_text_message('Processing request...'),
        )

        user_text = get_message_text(context.message)
        result = _convert_from_text(user_text) if user_text else 'No text input provided!'

        await task_updater.add_artifact(
            parts=[new_text_part(text=result, media_type='text/plain')]
        )
        await task_updater.update_status(
            state=TaskState.TASK_STATE_COMPLETED,
            message=new_text_message('Request is completed!'),
        )

    async def cancel(self, context: RequestContext, event_queue: EventQueue):
        raise NotImplementedError('Cancel is not supported.')
```{{copy}}

## 3. Create the Server

The server wires together the Agent Card, the Executor, and the A2A routes using Starlette.

```bash
touch agent_a_server.py
```{{exec}}

Add the following to `agent_a_server.py`:

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
```{{copy}}

## 4. Start the Agent

Open a **new terminal tab** (click the **+** button in the terminal UI) and start the Currency Converter:

```bash
cd ~/a2a-lab && source .venv/bin/activate && python starter/agent_a_server.py
```{{exec interrupt}}

You should see uvicorn start and print `Uvicorn running on http://127.0.0.1:9000`.

## 5. Verify the Agent Card

In the **original terminal tab**, verify that the Agent Card is accessible:

```bash
curl -s http://127.0.0.1:9000/.well-known/agent-card.json | python -m json.tool
```{{exec}}

You should see a JSON document with the agent's name, skills, and capabilities.

Click **Continue** once the Agent Card returns valid JSON.
