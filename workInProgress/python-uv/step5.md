# Step 5: Pip Migration

Finally, let's demonstrate `uv`'s speed by migrating a traditional `requirements.txt` workflow.

1. Create a `requirements.txt` file:
```bash
echo "requests" > requirements.txt
```{{exec}}

2. Compile it to a lockfile:
```bash
uv pip compile requirements.txt -o requirements.lock
```{{exec}}

3. Sync it to the environment:
```bash
uv pip sync requirements.lock
```{{exec}}
