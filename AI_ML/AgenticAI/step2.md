# Step 2: Setup Inference Engine

Now we will install Ollama and run a tiny LLM for our agent.

### 1. Install Ollama
Run the official installation script:

`curl -fsSL https://ollama.com/install.sh | sh`{{exec}}

### 2. Verify the Installation
Check if the service is running:

`systemctl status ollama`{{exec}}

*(Press `q` to exit the status view).*

### 3. Run the Model
Pull and run the **Qwen 0.5B** model:

`ollama run qwen2.5:0.5b`{{exec}}

Once the model downloads, you will see an interactive prompt `>>>`. Test it with:
`Write a JSON object representing a user named Alice aged 25.`

To exit the prompt, type `/exit`.
