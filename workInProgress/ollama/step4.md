# Step 4: Manage Models

It's important to know how to manage the models you've downloaded.

### Task
1. List your downloaded models:
```bash
ollama list
```{{exec}}

2. To remove a model to free up space:
```bash
ollama rm tinyllama
```{{exec}}

3. If you have multiple models, you can switch between them by simply running the specific model you want to use:
```bash
ollama run <model_name>
```
*(You would need to pull/download the model first if it's not present.)*
