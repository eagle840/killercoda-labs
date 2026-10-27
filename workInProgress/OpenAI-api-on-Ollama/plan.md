# Plan: OpenAI API on Ollama

## Goal
Learn to use Ollama's OpenAI-compatible API, progressing from simple chat completions to reasoning/thinking and tool calling, then compare with the Responses API.

## Environment
- Backend: ubuntu-4GB
- Install: Ollama, uv, Python, openai SDK
- Models: qwen2.5:3b-instruct (simple), qwen3:8b (advanced reasoning/tools)

## Lab Flow
1. Install Ollama (curl install, start service, verify)
2. Setup with uv (init project, add openai, pull qwen2.5:3b-instruct)
3. Simple Chat Completions (system/user, temperature, non-streaming, streaming)
4. Reasoning & Thinking (pull qwen3:8b, compare responses, see reasoning)
5. Tools & Function Calling (define get_weather tool, mock execution, tool result)
6. Responses API (client.responses.create, compare vs chat.completions)

## Notes
- Use api_key="ollama" (any string works)
- base_url=http://localhost:11434/v1
- Mock tools, no external API calls
- Call out differences in Responses API support
- Add troubleshooting notes
