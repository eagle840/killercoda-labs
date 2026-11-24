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