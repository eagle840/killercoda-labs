# Step 2: Setup Environment with uv

We'll use `uv` to manage our Python environment and dependencies.

## Install uv

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```{{execute}}

Add uv to your PATH for this session:

```bash
source $HOME/.cargo/env 2>/dev/null || source $HOME/.local/bin/env 2>/dev/null || export PATH="$HOME/.local/bin:$PATH"
```{{execute}}

Verify:

```bash
uv --version
```{{execute}}

## Create Project

```bash
mkdir -p ~/ollama-openai-lab && cd ~/ollama-openai-lab
uv init
```{{execute}}

## Add OpenAI SDK

```bash
uv add openai
```{{execute}}

## Pull the Simple Model

We'll start with `qwen2.5:3b-instruct` - fast and reliable:

```bash
ollama pull qwen2.5:3b-instruct
```{{execute}}

Verify it's available:

```bash
ollama list
```{{execute}}

**What you learned:** Set up a Python project with uv and pulled a small chat model for simple completions.
