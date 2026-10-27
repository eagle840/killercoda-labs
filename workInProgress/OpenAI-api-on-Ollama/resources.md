# Resources

## Documentation
- [Ollama Documentation](https://github.com/ollama/ollama)
- [Ollama OpenAI Compatibility](https://github.com/ollama/ollama/blob/main/docs/openai.md)
- [OpenAI Python SDK](https://github.com/openai/openai-python)
- [uv Documentation](https://docs.astral.sh/uv/)

## Models Used
- [qwen2.5:3b-instruct](https://ollama.com/library/qwen2.5) - Fast, reliable for basic chat
- [qwen3.5:2b](https://ollama.com/library/qwen3.5) - Reasoning-capable with tool support, fits in 4GB environments

## Tips & Notes
- Any API key string works with Ollama (e.g., "ollama", "dummy")
- Base URL: `http://localhost:11434/v1`
- For tool calling, model support varies - Qwen3 works well
- Responses API support depends on Ollama version
- Pull larger models in later steps to save time

## Troubleshooting
- If Ollama isn't responding: `systemctl restart ollama`
- Check logs: `journalctl -u ollama -n 50`
- Verify API: `curl http://localhost:11434/v1/models`
