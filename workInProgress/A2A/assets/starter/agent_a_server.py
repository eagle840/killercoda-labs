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
