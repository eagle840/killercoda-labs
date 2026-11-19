# Step 4: Manage Models

It's important to know how to manage the models you've downloaded.

### Task
1. List your downloaded models:
```bash
ollama list
```{{exec}}

2. Download and run a second model, such as `qwen2.5-coder:1.5b`:
```bash
ollama pull qwen2.5-coder:1.5b
```{{exec interrupt}}

3. To remove a model to free up space:
```bash
ollama rm tinyllama
```{{exec}}

4. If you have multiple models, you can switch between them by simply running the specific model you want to use:
```bash
ollama run <model_name>
```
*(You would need to pull/download the model first if it's not present.)*

### Pull and inspect a decision model

Not every model is a chat model. `tev1:0.8b` is a small **decision model**: it classifies an input against a set of criteria you supply, instead of producing free-form prose. Because its behaviour differs from a normal LLM, it is worth learning how to check what a model can do before you use it.

5. Pull the decision model:
```bash
ollama pull tev1:0.8b
```{{exec interrupt}}

6. Ask the Ollama API to describe the model. The `/api/show` endpoint returns the model's metadata, including a `capabilities` list. This is a reliable way to query *any* model and see what it can do:
```bash
curl http://localhost:11434/api/show -d '{
  "model": "tev1:0.8b"
}'
```{{exec}}

The JSON response includes details such as the model family, parameter size, and a `capabilities` array (for example `completion`, `tools`, or `vision`). Get into the habit of running this before building on an unfamiliar model.

7. Run the decision model using the `/v1/systemone` endpoint. Here we pass a support ticket in `state` and ask the model to choose a `label` from three defined criteria:
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

The model should select `bug`, because the state describes software errors. This shows how a decision model turns unstructured text into a structured, schema-driven answer — useful for ticket routing, classification, and other automated decisions.

### What you learned

- How to pull, list, remove, and switch between downloaded models.
- How to query `/api/show` to discover a model's capabilities before using it.
- How to run a decision model through `/v1/systemone` to get a structured choice from defined criteria.
