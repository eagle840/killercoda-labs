# Step 5: Tools & Function Calling

Now let's use function/tool calling with the advanced model. We'll define a mock `get_weather` function and walk through the full tool calling flow.

## Create a Tool Calling Example

Create `tool_calling.py`:

```bash
cat > tool_calling.py << 'PY'
from openai import OpenAI
import json

client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama",
)

# Define our tool
tools = [
    {
        "type": "function",
        "function": {
            "name": "get_weather",
            "description": "Get the current weather for a location",
            "parameters": {
                "type": "object",
                "properties": {
                    "location": {
                        "type": "string",
                        "description": "The city and state, e.g. San Francisco, CA",
                    }
                },
                "required": ["location"],
            },
        },
    }
]

# Initial request
messages = [
    {"role": "user", "content": "What's the weather like in Boston, MA?"}
]

response = client.chat.completions.create(
    model="qwen3:8b",
    messages=messages,
    tools=tools,
    tool_choice="auto",
)

response_message = response.choices[0].message
tool_calls = response_message.tool_calls

if tool_calls:
    print("Tool calls made:")
    for tool_call in tool_calls:
        print(f"  - {tool_call.function.name}({tool_call.function.arguments})")
    
    # Mock function execution
    messages.append(response_message)
    
    for tool_call in tool_calls:
        if tool_call.function.name == "get_weather":
            args = json.loads(tool_call.function.arguments)
            location = args.get("location")
            # Mock response
            weather_result = {
                "location": location,
                "temperature": "72°F",
                "condition": "Sunny",
                "humidity": "45%"
            }
            messages.append({
                "role": "tool",
                "tool_call_id": tool_call.id,
                "name": tool_call.function.name,
                "content": json.dumps(weather_result),
            })
    
    # Get final response
    second_response = client.chat.completions.create(
        model="qwen3:8b",
        messages=messages,
        tools=tools,
    )
    print("\nFinal answer:")
    print(second_response.choices[0].message.content)
else:
    print(response_message.content)
PY
```{{execute}}

Run it:

```bash
uv run python tool_calling.py
```{{execute}}

## Troubleshooting

- If the model doesn't call the tool, try rephrasing or check if the model supports function calling
- Not all models support tools equally well through Ollama's OpenAI compatibility layer
- If you get errors, make sure `qwen3:8b` is fully downloaded (`ollama list`)

**What you learned:** Implemented the full tool calling flow - define tools, detect tool calls, execute them (mocked), and feed results back for a final answer.
