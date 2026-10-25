# Step 4: Install Ollama and TinyLlama

Now you need a model to power the chatbot. [Ollama](https://ollama.com) runs models locally and exposes both its native API and an **OpenAI-compatible** API at `/v1`.

In this step you will install Ollama, start its server if necessary, pull **TinyLlama**, and verify the OpenAI endpoint with the Python SDK.

## Install Ollama

Run the official install script:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```{{exec}}

This downloads the Ollama runtime and may take a minute or two. Verify the CLI:

```bash
ollama --version
```{{exec}}


## Pull TinyLlama

TinyLlama is a 1.1-billion-parameter model that fits comfortably in the lab's memory. The quantized build is roughly 640 MB.

```bash
ollama pull tinyllama
```{{exec}}

This downloads the model and can take several minutes depending on network speed. Confirm that it is available locally:

```bash
ollama list
```{{exec}}

Optionally, try the model through Ollama's native CLI:

```bash
ollama run tinyllama "Explain what Gradio is in one short sentence."
```{{exec}}

The first request loads the model into memory, so it can take 20 seconds or more before any text appears.

## Verify the OpenAI-compatible endpoint

Ollama exposes downloaded models at `http://localhost:11434/v1`. Check the model list:

```bash
curl -s http://localhost:11434/v1/models | jq
```{{exec}}

You should see `tinyllama` in the response. The API key is required by the OpenAI SDK but ignored by Ollama, so any non-empty value works.

Create a small test script in the project:

```bash
cd ~/gradio-lab
cat > test_api.py <<'EOF'
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:11434/v1/",
    api_key="ollama",  # required by the SDK, ignored by Ollama
)

response = client.chat.completions.create(
    model="tinyllama",
    messages=[
        {"role": "system", "content": "Answer in one short sentence."},
        {"role": "user", "content": "What is Gradio?"},
    ],
    temperature=0.2,
    max_tokens=80,
)

print(response.choices[0].message.content)
EOF
```{{exec}}

Run it and measure how long the request takes:

```bash
cd ~/gradio-lab
time uv run python test_api.py
```{{exec}}

The first call is the slowest because the model has to load. Later calls are faster. Check which models are currently loaded in memory:

```bash
ollama ps
```{{exec}}



You now have a local OpenAI-compatible chat endpoint. In the final step you will connect Gradio to it.
