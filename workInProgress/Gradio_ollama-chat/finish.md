# Finish

Congratulations! You have built a complete local LLM application with Gradio and Ollama.

## What you accomplished

1. Installed `uv` and created a reproducible Python project with `pyproject.toml` and `uv.lock`.
2. Built a Gradio `gr.Interface` demo from a plain Python function.
3. Built a custom `gr.Blocks` layout with events and called it through Gradio's API.
4. Installed Ollama, pulled TinyLlama, and verified the OpenAI-compatible endpoint.
5. Built a streaming `gr.ChatInterface` chatbot backed by your local model.

## The full architecture

```text
Browser
   |
   v
Gradio app on port 7860
   |
   v
OpenAI Python SDK  ->  http://localhost:11434/v1/
                              |
                              v
                         Ollama server
                              |
                              v
                         TinyLlama
```

The same pattern works with any OpenAI-compatible provider. Change `base_url`, `api_key`, and `MODEL` to point at a cloud API or another local runtime.

## Cleanup

Stop the Gradio app:

```bash
pkill -f "[p]ython chat_app.py" 2>/dev/null || true
pkill -f "[g]radio app.py" 2>/dev/null || true
```{{exec}}

Unload the model from memory:

```bash
ollama stop tinyllama
```{{exec}}

If you started Ollama manually with `ollama serve`, stop that process too:

```bash
pkill -f "[o]llama serve" 2>/dev/null || true
```{{exec}}

The model stays on disk for future sessions. To reclaim disk space, remove it:

```bash
ollama rm tinyllama
```{{exec}}

## Ideas for next steps

- Add a system-prompt textbox with `gr.ChatInterface(additional_inputs=[...])`.
- Try `gr.load_chat()` to wrap the endpoint in a single line.
- Use `gr.Blocks` with a `gr.Chatbot` to build a custom chat layout.
- Add file upload with `multimodal=True` and a vision-capable model.
- Deploy the app with `share=True` or to Hugging Face Spaces.
- Swap TinyLlama for a larger model when you have more memory and CPU.

## Further reading

See `resources.md` for links to the Gradio, uv, and Ollama documentation.
