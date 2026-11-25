# Step 6: Run a Decision Model

Not every model is a chat model. `tev1:0.8b` is a small **decision model**: it classifies an input against criteria you supply, instead of producing free-form prose. Its behaviour differs from a normal LLM, so it is worth checking what a model can do before using it.

### Task

1. Pull the decision model:
```bash
ollama pull tev1:0.8b
```{{exec interrupt}}

2. Ask the Ollama API to describe the model. The `/api/show` endpoint returns metadata, including a `capabilities` list:
```bash
curl http://localhost:11434/api/show -d '{
  "model": "tev1:0.8b"
}'
```{{exec}}

The JSON response includes details such as the model family, parameter size, and a `capabilities` array (for example `completion`, `tools`, or `vision`). Use this before building on an unfamiliar model.

3. Run the decision model using the `/v1/systemone` endpoint. Here we pass a support ticket in `state` and ask the model to choose a `label` from three defined criteria:
```bash
curl http://localhost:11434/v1/systemone \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "tev1:0.8b",
    "state": "Our checkout has returned 500 errors since 9am.",
    "questions": {
      "label": {
        "type": "choice",
        "instructions": "Which label fits this ticket?",
        "criteria": {
          "billing": "Payments and refunds",
          "bug": "Software errors",
          "account": "Login and account access"
        }
      }
    }
  }'
```{{exec}}

The model should select `bug`, because the state describes software errors. This shows how a decision model turns unstructured text into a structured, schema-driven answer.

### What you learned

- How to query `/api/show` to discover a model's capabilities before using it.
- How to run a decision model through `/v1/systemone` to get a structured choice from defined criteria.
