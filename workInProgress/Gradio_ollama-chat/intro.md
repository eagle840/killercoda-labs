# Introduction to Gradio

Welcome to the **Introduction to Gradio** lab!

[Gradio](https://www.gradio.app) is an open-source Python library for building web interfaces around machine learning models, APIs, or any Python function. You do not need HTML, CSS, or JavaScript to get started.

In this lab you will build two applications:

1. A classic Gradio demo using `gr.Interface` and `gr.Blocks`.
2. A local chatbot that talks to **TinyLlama** running in **Ollama**, using Ollama's OpenAI-compatible API.

Python is managed with [uv](https://docs.astral.sh/uv/) throughout the lab instead of `pip` and `venv`.

## What you will learn

- Install `uv` and create a Python project with a locked, reproducible environment.
- Build a Gradio `Interface` from a normal Python function.
- Lay out a custom app with `gr.Blocks` and call it through Gradio's built-in API.
- Install Ollama, pull a small model, and verify the OpenAI-compatible endpoint.
- Stream model responses into a `gr.ChatInterface` chatbot.
- Troubleshoot the moving parts of a local LLM stack.

## Architecture

```text
Browser
   |
   v
Gradio app (port 7860)
   |
   v
OpenAI Python SDK  ->  http://localhost:11434/v1/
                              |
                              v
                         Ollama server
                              |
                              v
                         TinyLlama model
```

## Before you begin

- The lab uses the **Ubuntu 4 GB** environment because Ollama loads the model into memory.
- Pulling the model downloads roughly **640 MB**. Allow a few minutes.
- Inference runs on **CPU only**, so replies can take several seconds. The chat app streams tokens as they are generated.
- The Gradio app listens on port **7860**. Use the **Traffic** panel, or the links in the steps, to open it in your browser.

Let's get started!
