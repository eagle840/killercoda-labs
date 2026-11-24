import asyncio
import re
import httpx
from a2a.client import A2ACardResolver, ClientConfig, create_client
from a2a.helpers import get_message_text, new_text_message
from a2a.types import Role, SendMessageRequest


def extract_text(task) -> str:
    parts = []
    for artifact in getattr(task, 'artifacts', None) or []:
        text = get_message_text(artifact)
        if text:
            parts.append(text)
    if getattr(task, 'message', None):
        text = get_message_text(task.message)
        if text:
            parts.append(text)
    return ' | '.join(parts)


async def call_agent(base_url: str, message_text: str) -> str:
    async with httpx.AsyncClient(timeout=30.0) as httpx_client:
        resolver = A2ACardResolver(
            httpx_client=httpx_client, base_url=base_url
        )
        card = await resolver.get_agent_card()

        client = await create_client(
            agent=card, client_config=ClientConfig(streaming=False)
        )
        message = new_text_message(message_text, role=Role.ROLE_USER)
        request = SendMessageRequest(message=message)

        output = []
        async for chunk in client.send_message(request):
            text = extract_text(chunk)
            if text:
                output.append(text)
        await client.close()
        return ' '.join(output)


async def main():
    print('=' * 60)
    print('A2A Orchestrator — Currency Conversion + Tax Calculation')
    print('=' * 60)

    # Step 1: Convert currency
    print('\n[Step 1] Calling Currency Converter (Agent A)...')
    conversion = await call_agent(
        'http://127.0.0.1:9000',
        'Convert 100 USD to EUR',
    )
    print(f'  Result: {conversion}')

    # Step 2: Extract the converted amount from the response
    match = re.search(r'=\s*([\d.]+)\s+(\w+)', conversion)
    if match:
        converted_amount = float(match.group(1))
        target_currency = match.group(2)
        print(f'\n  Extracted: {converted_amount} {target_currency}')
    else:
        converted_amount = 92.0
        target_currency = 'EUR'
        print('\n  Using fallback amount: 92.00 EUR')

    # Step 2: Calculate tax on the converted amount
    print(f'\n[Step 2] Calling Tax Calculator (Agent B)...')
    tax_request = f'Calculate 20% tax on {converted_amount}'
    print(f'  Request: {tax_request}')
    tax_result = await call_agent(
        'http://127.0.0.1:9001',
        tax_request,
    )
    print(f'  Result: {tax_result}')

    print('\n' + '=' * 60)
    print('Pipeline complete!')
    print(f'  1. 100.00 USD = {converted_amount:.2f} {target_currency}')
    print(f'  2. 20% VAT on {converted_amount:.2f} {target_currency}')
    print('=' * 60)


if __name__ == '__main__':
    asyncio.run(main())