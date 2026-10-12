# Step 3

Replace this placeholder with the next task for the vLLM lab.

A common candidate: start the OpenAI-compatible server and send a request.

```bash
vllm serve <model-id> --port 8000 &
```{{exec}}

```bash
curl http://localhost:8000/v1/models
```{{exec}}

**What you learned:** how to expose vLLM's OpenAI-compatible API endpoint.
