# OpenAI API on Ollama

*Last updated: 2026-10-28*

## Overview

Ollama provides an OpenAI-compatible API, allowing you to use the OpenAI Python SDK to interact with locally running models. This means you can write code against `http://localhost:11434/v1` without needing an OpenAI API key or internet access for inference.

## What You'll Learn

- Install and run Ollama
- Use `uv` to manage a Python project and dependencies
- Use the OpenAI SDK with Ollama for Chat Completions (streaming and non-streaming)
- Explore reasoning/thinking with more advanced models
- Implement function/tool calling
- Compare Chat Completions vs the Responses API

## Important Notes

- **API Key**: Any string works with Ollama's OpenAI-compatible endpoint (e.g., `api_key="ollama"`).
- **Base URL**: Use `http://localhost:11434/v1` instead of `https://api.openai.com/v1`.
- **Model Selection**: You'll start with a small fast model, then move to a larger reasoning-capable model.
- **Production Disclaimer**: The patterns shown here are for learning purposes. For production use, consider authentication, rate limiting, and proper error handling.

**Time:** ~75 minutes | **Difficulty:** Intermediate
