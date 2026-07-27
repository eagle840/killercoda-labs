# Step 3: Run the Model

Now that we have chosen `tinyllama`, let's run it.

### Task
1. First, you need to ensure Ollama is installed (it's not by default, let's install it).

```bash
curl -fsSL https://ollama.com/install.sh | sh
```{{exec}}

2. Once installed, run the `tinyllama` model. The `ollama run` command will automatically download the model if it's not present.

```bash
ollama run tinyllama
```{{exec interrupt}}

*(Note: The command will enter an interactive mode. Once you are done, you can type `/bye` to exit.)*
