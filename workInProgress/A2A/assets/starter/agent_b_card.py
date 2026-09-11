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
