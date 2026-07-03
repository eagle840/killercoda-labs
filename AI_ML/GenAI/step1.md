# From Gemini:


 When evaluating local language models for agentic workflows on minimal hardware, you can go incredibly small. While there are experimental models with only a few million parameters, the **smallest practically functional text-based LLMs** that can actually follow instructions and route basic tasks sit under 1 billion parameters.

The current record-holders for the absolute smallest, coherent open-source text models are:

* **SmolLM2 (135M parameters):** Hugging Face’s ultra-small model. Quantized, it requires **less than 100 MB of RAM**. It is perfect for tiny text tasks but has very limited reasoning capacity.
* **Qwen2.5-0.5B / Qwen3-0.6B (500M–600M parameters):** Requires roughly **350 MB–400 MB of RAM** when quantized. Surprisingly capable for its size, it is widely used in CPU-only environments for basic agent tool-routing and JSON extraction.

Since you are running on an Ubuntu machine with **no GPU (CPU-only)**, the most efficient and painless way to run these is using **Ollama**. It automatically optimizes for CPU execution using your system's RAM.

---

## Step-by-Step Guide: Running on Ubuntu (CPU-Only)

### 1. Install Ollama via Terminal

Open your Ubuntu terminal and run the official installation script. It will automatically detect that you don't have an NVIDIA GPU and configure itself for CPU inference:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```{{exec}}

### 2. Verify the Installation

Ensure the Ollama service is running properly in the background:

```bash
systemctl status ollama
```{{exec}}

*(Press `q` to exit the status view).*

### 3. Download and Run the Tiny Model

To pull and instantly start a conversation with the **Qwen 0.5B** model (recommended for its balance of tiny size and basic functionality), run:

```bash
ollama run qwen2.5:0.5b
```{{exec}}

If you want to go even smaller with the **SmolLM 135M** model, use:

```bash
ollama run smollm:135m
```{{copy}}

### 4. Test the Model

Once the model downloads, you will see an interactive prompt `>>>`. Test its response speed on your CPU:

```text
Write a JSON object representing a user named Alice aged 25.
```{{copy}}

To exit the prompt, type `/exit`.

---

## Integrating with an Agentic System

Because these models run as a local API server in the background, your agent framework (like AutoGen, CrewAI, or a custom script) can interact with it at `http://localhost:11434` using standard OpenAI-compatible API calls.

Are you planning to use a specific agent framework (like LangChain or CrewAI) for this setup, or are you building the orchestration layer from scratch?