# Step 7: Installing Custom Skills from `skills.sh`

### 1. Understanding Skills
Skills are packaged instructions and resources that an agent can load on demand to perform a specific, well-defined task. While an agent acts as the worker, a skill is a reusable capability or knowledge package (like a playbook).

In OpenCode, you can install skills, which are typically defined by folders containing a `SKILL.md` file (containing instructions) and optional supporting files.

### 2. Install a Skill
You can install skills directly from `skills.sh` within the CLI:
```text
/install <skill-name>
```{{copy}}
Confirm any permission prompts that appear.

### 3. Trigger the Skill
After installing the skill, perform a quick application restart. You can then trigger the skill using:
```text
/skills
```{{copy}}
This will list and allow you to execute the newly installed workflow.

---

### Practical Example: Skill Environment Setup with MiniStack

We'll use a practical example of setting up a workflow environment using Ministack, an AWS emulator.

#### Initial setup

- try the website for documentation and AWS101 https://ministack.org/

To view docker-compose:

`cat docker-compose.yml`{{exec}}

Let's startup the Ministack:
`docker-compose up -d`{{exec}}

When ready, open another CLI tab and install the tools we'll be using:

#### Install AWS CLI & Tools

`sudo apt update && sudo apt install -y zip jq`{{exec}}

`curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"`{{exec}}

`unzip awscliv2.zip`{{exec}}

`sudo ./aws/install`{{exec}}

`rm -rf awscliv2.zip ./aws`{{exec}}

`aws --version`{{exec}}

---

### Networking Note
MiniStack uses a dedicated Docker network called `lab_net` to allow the Lambda containers it spins up to communicate back to the main service. This is defined in your `docker-compose.yml`.

#### 2. Configure for MiniStack
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

#### 3. Testing the Connection
Now that you have both MiniStack (from your Docker Compose) and the CLI ready, try to create your first bucket:

#### Confirm ministack is up

`curl http://localhost:4566/_ministack/health | jq`{{exec}}

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://my-first-bucket
```{{exec}}

Let's make an alias:

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
