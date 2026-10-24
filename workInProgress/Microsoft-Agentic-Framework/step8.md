# Host Your Agent

? remove this?

`uv add gradio autogen-agentchat autogen-ext`{{exec}}

`export OPENAI_API_KEY="your-api-key-here"`

```python
import asyncio
import os
import gradio as gr
from autogen_agentchat.agents import AssistantAgent
from autogen_ext.models.openai import OpenAIChatCompletionClient

# 1. Initialize the Microsoft AutoGen LLM Client
# It automatically picks up the OPENAI_API_KEY environment variable.
model_client = OpenAIChatCompletionClient(model="gpt-4o-mini")

# 2. Define the AutoGen Agent
agent = AssistantAgent(
    name="MathWizard",
    model_client=model_client,
    system_message="You are a brilliant, playful math tutor. Explain things using emojis and simple breakdowns."
)

# 3. Create the Asynchronous Gradio Prediction Function
async def chat_with_agent(message, history):
    """
    Sends the user message to the AutoGen agent and streams the response text.
    """
    try:
        # Wrap history into a structure if needed, or simply pass the new message
        # We pass the message asynchronously to the agent's run method
        response = await agent.run(task=message)
        
        # Stream or yield the text out to the Gradio UI
        # For simplicity, we yield the complete final text content
        yield response.messages[-1].content
        
    except Exception as e:
        yield f"⚠️ Error: {str(e)}. Please check your OPENAI_API_KEY."

# 4. Mount and Launch the Gradio Interface
app = gr.ChatInterface(
    fn=chat_with_agent,
    title="🧙‍♂️ Microsoft AutoGen Meet Gradio",
    description="Ask your AutoGen assistant anything! Powered by `uv` and asynchronous execution.",
    type="messages" # Optimized for newer Gradio conversational schemas
)

if __name__ == "__main__":
    # Launch Gradio on local port 7860
    app.queue().launch()
```{{copy}}

`uv run main.py`{{exec}}