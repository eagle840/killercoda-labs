# Step 7: Explore a Thinking Model

So far we have used `tinyllama`, a tiny general-purpose model. Now let's look at a model that
actually reasons before it answers.

We are going to use **`bonsai-2:4b`**, pulled from the Ollama library:
https://ollama.com/library/bonsai-2

We chose it because the library page lists it as a **thinking** model (the `thinking` badge on that
page), and the 4B tag is only **1.6 GB** on disk. That fits in the 4 GB of RAM this lab provides —
check `free -m` from step 1 — while still giving us a real reasoning loop, unlike `gemma3:1b`.

## 1. Pull the model

Downloading 1.6 GB takes a minute or two:

```bash
ollama pull bonsai-2:4b
```{{exec interrupt}}

Check the model's capabilities:

```bash
curl http://localhost:11434/api/show -d '{"model":"bonsai-2:4b"}'
```{{execute}}

## 2. Start an interactive session

```bash
ollama run bonsai-2:4b
```{{exec interrupt}}

You should now see the `>>>` prompt.

## 3. Ask a question

Type this at the `>>>` prompt:

```bash
What is the capital of France
```

You should see the model's thinking before its answer.

When you are finished, exit with:

```bash
/bye
```

### What you learned

- How to pick a thinking model using its size and capabilities.
- How to use `/api/show` to check what a model can do.
- How thinking appears in an interactive Ollama session.
