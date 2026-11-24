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
