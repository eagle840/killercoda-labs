# Step 4 Multi-Turn Conversations

taken from: https://learn.microsoft.com/en-us/agent-framework/get-started/multi-turn?pivots=programming-language-python

undate the code to 

Does followin allow sessions? https://learn.microsoft.com/en-us/python/api/agent-framework-core/agent_framework.openai.openaichatclient?view=agent-framework-python-latest


```python
        instructions="You are a friendly assistant. Keep your answers brief.",
    )
    session = agent.create_session()

    print(await agent.run("My name is Alice and I love hiking.", session=session))
    print(await agent.run("What do you remember about me?", session=session))



if __name__ == "__main__":
    asyncio.run(main())
```