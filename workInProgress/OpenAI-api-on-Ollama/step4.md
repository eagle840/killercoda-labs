# Step 4: Reasoning & Thinking

Now let's try a more advanced reasoning-capable model. We'll use `qwen3.5:2b` which has built-in thinking/reasoning capabilities and fits comfortably in a 4GB environment.

## Pull the Advanced Model

This may take a few minutes depending on network speed:

```bash
ollama pull qwen3.5:2b
```{{execute}}

## Compare Responses

Create `reasoning_chat.py`:

```bash
cat > reasoning_chat.py << 'PY'
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama",
)

response = client.chat.completions.create(
    model="qwen3.5:2b",
    messages=[
        {"role": "user", "content": "Solve step by step: A train travels 120 km at 60 km/h, then 90 km at 45 km/h. What is the average speed for the entire journey?"},
    ],
    temperature=0.7,
)

# Some models expose reasoning_content depending on SDK/version
msg = response.choices[0].message
if hasattr(msg, "reasoning_content") and msg.reasoning_content:
    print("=== THINKING ===")
    print(msg.reasoning_content)
    print("\n=== ANSWER ===")
print(msg.content)
PY
```{{execute}}

Run it:

```bash
uv run python reasoning_chat.py
```{{execute}}

## Observe

- Notice if you see separate reasoning/thinking output
- Compare the depth of explanation vs the simpler model
- Try asking a more complex multi-step question and observe the difference

**Note:** Ollama's OpenAI compatibility may expose reasoning differently across versions. If `reasoning_content` isn't present, the thinking may be included in the main content or handled differently.

**What you learned:** Switched to a reasoning-capable model and observed how it approaches complex problems differently than smaller models.
