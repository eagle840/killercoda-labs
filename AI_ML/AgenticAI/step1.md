# Setup AWS ministack

# Initial setup

we'll be using Ministack, an AWS emulator

- try the website for documentation and AWS101 https://ministack.org/

to view docker-compose

`cat docker-compose.yml`{{exec}}

Lets startup the Ministack  
`docker-compose up -d`{{exec}}



When ready, open another cli tab and install the tools we'll be using


## Install AWS CLI & Tools

`sudo apt update && sudo apt install -y zip jq`{{exec}}

`curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"`{{exec}}

`unzip awscliv2.zip`{{exec}}

`sudo ./aws/install`{{exec}}

`rm -rf awscliv2.zip ./aws`{{exec}}

`aws --version`{{exec}}

---

### Networking Note
MiniStack uses a dedicated Docker network called `lab_net` to allow the Lambda containers it spins up to communicate back to the main service. This is defined in your `docker-compose.yml`.



### 2. Configure for MiniStack
Once installed, the CLI defaults to looking for real AWS servers. You need to "trick" it into looking at your local MiniStack container. You have two ways to do this:

**Option A: The "Dummy" Configuration (Recommended for Labs)**
Run `aws configure` and enter these values:
* **AWS Access Key ID**: `test`
* **AWS Secret Access Key**: `test`
* **Default region name**: `us-east-1`
* **Default output format**: `json`

**Option B: The "One-Liner" Export**
If you don't want to go through the interactive prompt, just run this:
```bash
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
```{{exec}}

### 3. Testing the Connection
Now that you have both MiniStack (from your Docker Compose) and the CLI ready, try to create your first bucket:

### Confirm ministack is up

`curl http://localhost:4566/_ministack/health | jq`{{exec}}

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://my-first-bucket
```{{exec}}

lets make an alias:

`alias awslocal='aws --endpoint-url=http://localhost:4566'`{{exec}}



### Pro-Tip: Memory Limits
If Killercoda feels sluggish, you can add a resource limit to the `ministack` service block:
```yaml
    deploy:
      resources:
        limits:
          memory: 512M
```
*(MiniStack only needs about 30-50MB, but 512MB gives it breathing room to spin up those "real" RDS or Lambda containers without hitting the VM's ceiling.)*

# Setup Ollama


 When evaluating local language models for agentic workflows on minimal hardware, you can go incredibly small. While there are experimental models with only a few million parameters, the **smallest practically functional text-based LLMs** that can actually follow instructions and route basic tasks sit under 1 billion parameters.

The current record-holders for the absolute smallest, coherent open-source text models are:

* **SmolLM2 (135M parameters):** Hugging Face’s ultra-small model. Quantized, it requires **less than 100 MB of RAM**. It is perfect for tiny text tasks but has very limited reasoning capacity.
* **Qwen2.5-0.5B / Qwen3-0.6B (500M–600M parameters):** Requires roughly **350 MB–400 MB of RAM** when quantized. Surprisingly capable for its size, it is widely used in CPU-only environments for basic agent tool-routing and JSON extraction.

Since you are running on an Ubuntu machine with **no GPU (CPU-only)**, the most efficient and painless way to run these is using **Ollama**. It automatically optimizes for CPU execution using your system's RAM.

---

## Step-by-Step Guide: Running on Ubuntu (CPU-Only)

### 1. Install Ollama via Terminal

Open your Ubuntu terminal and run the official installation script. It will automatically detect that you don't have an NVIDIA GPU and configure itself for CPU inference:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```{{exec}}

### 2. Verify the Installation

Ensure the Ollama service is running properly in the background:

```bash
systemctl status ollama
```{{exec}}

*(Press `q` to exit the status view).*

### 3. Download and Run the Tiny Model

To pull and instantly start a conversation with the **Qwen 0.5B** model (recommended for its balance of tiny size and basic functionality), run:

```bash
ollama run qwen2.5:0.5b
```{{exec}}

If you want to go even smaller with the **SmolLM 135M** model, use:

```bash
ollama run smollm:135m
```{{copy}}

### 4. Test the Model

Once the model downloads, you will see an interactive prompt `>>>`. Test its response speed on your CPU:

```text
Write a JSON object representing a user named Alice aged 25.
```{{copy}}

To exit the prompt, type `/exit`.

---

## Integrating with an Agentic System

Because these models run as a local API server in the background, your agent framework (like AutoGen, CrewAI, or a custom script) can interact with it at `http://localhost:11434` using standard OpenAI-compatible API calls.

Are you planning to use a specific agent framework (like LangChain or CrewAI) for this setup, or are you building the orchestration layer from scratch?

--- Step 2

Boot up ministack,

Create a S3 with a open ai schema

I'll need an api service to reply to agentic quieries

I'll need a lambda funcation to call the API

The LLM will need to pull the openAPI schema and call the API

Question? if the API has an openAPI schema endpoint, why not use that