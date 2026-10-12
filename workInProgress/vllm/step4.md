# Step 4

Replace this placeholder with the final task for the vLLM lab.

A common candidate: query the completion endpoint and observe batching behaviour.

```bash
curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model": "<model-id>", "messages": [{"role": "user", "content": "Hello!"}]}'
```{{copy}}

**What you learned:** how to call vLLM's OpenAI-compatible chat endpoint.
