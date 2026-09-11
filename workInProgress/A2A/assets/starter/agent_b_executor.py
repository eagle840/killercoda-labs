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