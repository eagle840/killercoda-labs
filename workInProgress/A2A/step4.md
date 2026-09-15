# Build Tax Calculator Agent

Now build the second A2A server — a **Tax Calculator** agent on **port 9001**. This follows the same three-file pattern as the Currency Converter but with different business logic.

## 1. Create the Agent Card

```bash
cd ~/a2a-lab
```{exec}

```bash
touch agent_b_card.py
```{{exec}}

Add the following to `agent_b_card.py`:

```python
from a2a.types import AgentCapabilities, AgentCard, AgentInterface, AgentSkill

skill = AgentSkill(
    id='tax_calculator',
    name='Tax Calculator',
    description='Calculates tax amount and total given a percentage and base amount.',
    input_modes=['text/plain'],
    output_modes=['text/plain'],
    tags=['a2a', 'tax', 'calculator', 'finance'],
    examples=['Calculate 20% tax on 100', 'What is 15% VAT on 250.50'],
)

agent_card = AgentCard(
    name='Tax Calculator Agent',
    description='Calculates tax and total for a given percentage and amount.',
    version='0.0.1',
    default_input_modes=['text/plain'],
    default_output_modes=['text/plain'],
    capabilities=AgentCapabilities(streaming=False),
    supported_interfaces=[
        AgentInterface(
            protocol_binding='JSONRPC',
            url='http://127.0.0.1:9001',
            protocol_version='1.0',
        )
    ],
    skills=[skill],
)
```{{copy}}

## 2. Create the Agent Executor

```bash
touch agent_b_executor.py
```{{exec}}

Add the following to `agent_b_executor.py`:

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


def calculate_tax(amount: float, rate_percent: float) -> dict:
    tax = round(amount * (rate_percent / 100), 2)
    total = round(amount + tax, 2)
    return {'tax': tax, 'total': total}


def _calculate_tax_from_text(user_text: str) -> str:
    match = re.search(
        r'(\d+(?:\.\d+)?)\s*%\s*(?:tax|vat)\s+on\s+(\d+(?:\.\d+)?)',
        user_text,
        re.IGNORECASE,
    )
    if not match:
        return 'Could not parse request. Try: "Calculate 20% tax on 100"'
    rate = float(match.group(1))
    amount = float(match.group(2))
    result_data = calculate_tax(amount, rate)
    return (
        f'Tax ({rate}%): {result_data["tax"]:.2f}, '
        f'Total: {result_data["total"]:.2f}'
    )


class TaxCalculatorExecutor(AgentExecutor):
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
        result = _calculate_tax_from_text(user_text) if user_text else 'No text input provided!'

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

```bash
touch agent_b_server.py
```{{exec}}

Add the following to `agent_b_server.py`:

```python
import uvicorn
from a2a.server.request_handlers import DefaultRequestHandler
from a2a.server.routes import create_agent_card_routes, create_jsonrpc_routes
from a2a.server.tasks import InMemoryTaskStore
from starlette.applications import Starlette
from agent_b_executor import TaxCalculatorExecutor
from agent_b_card import agent_card


request_handler = DefaultRequestHandler(
    agent_executor=TaxCalculatorExecutor(),
    task_store=InMemoryTaskStore(),
    agent_card=agent_card,
)

routes = []
routes.extend(create_agent_card_routes(agent_card))
routes.extend(create_jsonrpc_routes(request_handler, '/'))
app = Starlette(routes=routes)

if __name__ == '__main__':
    uvicorn.run(app, host='127.0.0.1', port=9001)
```{{copy}}

## 4. Start the Tax Calculator

Open **another new terminal tab** (click the **+** button) and start the second agent:

```bash
cd ~/a2a-lab && source .venv/bin/activate && python starter/agent_b_server.py
```{{exec interrupt}}

You should see uvicorn start on port 9001.

## 5. Verify the Agent Card

Back in the **original terminal tab**:

```bash
curl -s http://127.0.0.1:9001/.well-known/agent-card.json | python -m json.tool
```{{exec}}

## 6. Test with curl

```bash
curl -s -X POST http://127.0.0.1:9001/ \
  -H "Content-Type: application/json" \
  -H "A2A-Version: 1.0" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "SendMessage",
    "params": {
      "message": {
        "role": "ROLE_USER",
        "parts": [{"text": "Calculate 20% tax on 100"}],
        "messageId": "tax-test-001"
      }
    }
  }' | python -m json.tool
```{{exec}}

You should see `Tax (20%): 20.00, Total: 120.00` in the response.

Click **Continue** once both agents are running and verified.
