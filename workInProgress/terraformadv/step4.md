## Taskfile


`nano Taskfile.yml`{{exec}}

```
version: '3'

vars:
  # Define variables once
  TF_STATE_DB: "postgres://postgres:password@localhost:5432/terraform_state?sslmode=disable"
  VAULT_ADDR: "http://localhost:8200"
  VAULT_TOKEN: "learn-token"

tasks:
  init:
    desc: "Initialize Terraform with Postgres backend"
    cmds:
      - terraform init -backend-config="conn_str={{.TF_STATE_DB}}"

  plan:
    desc: "Run a Terraform plan with Vault environment variables"
    env:
      VAULT_ADDR: "{{.VAULT_ADDR}}"
      VAULT_TOKEN: "{{.VAULT_TOKEN}}"
    cmds:
      - terraform plan

  apply:
    desc: "Apply the infrastructure changes"
    deps: [init] # Runs 'init' automatically before applying
    env:
      VAULT_ADDR: "{{.VAULT_ADDR}}"
      VAULT_TOKEN: "{{.VAULT_TOKEN}}"
    cmds:
      - terraform apply -auto-approve

  console:
    desc: "Open the terraform console with environment context"
    env:
      VAULT_ADDR: "{{.VAULT_ADDR}}"
      VAULT_TOKEN: "{{.VAULT_TOKEN}}"
    interactive: true
    cmds:
      - terraform console
```{{copy}}

# How to use

## Install

`sh -c "$(curl -ssL https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin`{{exec}}

Confirm install

`task --help`{{exec}}

## Run the task 'init' in the file

`task init`{{exec}}

## Check options

`task --list`{{exec}}

## Running other commands in 'Task'

Yes, **Task** handles this exactly like `make`, but with a cleaner execution model. 

At its core, Task is a **command runner**. Anything you can type into your Ubuntu terminal—whether it's `terraform`, `docker`, `vault`, `kubectl`, or even a custom Python script—can be executed inside a `cmds:` block.

Here is how Task manages external apps and why it’s actually a bit more robust than Make:

### 1. Simple Command Execution
You don't need special plugins to run other apps. If the app is in your `$PATH`, Task will find it.

```yaml
tasks:
  verify:
    desc: "Check if all our tools are installed"
    cmds:
      - terraform version
      - vault version
      - docker version
      - pg_isready -h localhost -p 5432  # Postgres client tool
```

### 2. Modern Dependency Management
In `make`, you'd list file targets. In Task, you can list **other tasks** as dependencies. This allows you to chain different apps together effortlessly.

```yaml
tasks:
  setup:
    cmds:
      - docker-compose up -d  # Start the DB/Vault
      - sleep 5               # Give them time to breathe

  init:
    deps: [setup]             # 'setup' runs first
    cmds:
      - terraform init
```

### 3. Smart Handling of "Silent" Commands
One of the best "advanced" features is the `silent: true` flag. If you are running an app that outputs a lot of "noise" (like a linter or a security scanner) and you only care if it fails, Task lets you keep your terminal clean.

```yaml
tasks:
  lint:
    desc: "Clean up the code"
    cmds:
      - tflint .
      - terraform fmt
    silent: true  # Doesn't echo the command itself to the terminal
```

### 4. Direct Piping and Scripting
Just like Make, you can use pipes, redirects, and subshells. This is great for apps that need to pass data to each other:

```yaml
tasks:
  get-secret:
    cmds:
      # Use Vault to get a secret and pipe it into a local file
      - vault kv get -field=password secret/db > db_pass.txt
```

---

### Task vs. Make: The Execution Engine

The biggest difference is how they handle the **Shell**. 
* **Make** often defaults to `/bin/sh` (which can be restrictive). 
* **Task** allows you to define which shell to use globally or per task. If you've written a complex `bash` script, you can ensure Task uses `/bin/bash` to run it, avoiding the "it works in my terminal but not in my Makefile" bug.



### Pro-Tip for your Lab:
Since you are using **Postgres** and **Vault**, you might have a task called `doctor` that runs `docker ps`, `vault status`, and `pg_isready`. It’s a great way to use Task to "orchestrate" all those different installed apps to prove your environment is ready before you ever touch Terraform.

**Would you like to add a "Doctor" or "Pre-check" task to your Taskfile to see this in action?**

