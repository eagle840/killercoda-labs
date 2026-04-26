# initial setup


Start a postgress database to store the terraform backend.   
`docker-compose up -d`{{exec}}


While that sets up:

## Using tenv to control tf versioning

Instead of installing terraform directly, we'll install a helper tool 'tenv'


https://github.com/tofuutils/tenv

```
LATEST_VERSION=$(curl --silent https://api.github.com/repos/tofuutils/tenv/releases/latest | jq -r .tag_name)
curl -O -L "https://github.com/tofuutils/tenv/releases/latest/download/tenv_${LATEST_VERSION}_amd64.deb"
sudo dpkg -i "tenv_${LATEST_VERSION}_amd64.deb"
```{{exec}}

`tenv --help`{{exec}}

lets lets off the available terraform versions:

`tenv tf list-remote`{{exec}}

and install 1.14.9 and use it@


`tenv tf install 1.14.9`{{exec}}

`tenv tf use 1.14.9`{{exec}}

`terraform version`{{exec}}

# Confirm 


#### Check if it's working:
1.  **Browser:** Navigate to `http://localhost:8200` [SITE]({{TRAFFIC_HOST1_8200}}). Sign in with the token `learn-token`.
2.  **Terminal:** Run `curl http://localhost:8200/v1/sys/health`{{exec}}. You should get a JSON response with `"sealed": false`.

---

### Phase 2: Prepare the "Infrastructure"
Since you already have Postgres running, we need to ensure it has a database for Terraform to use. Connect to your Postgres instance and run:

[ACCESS Adminer DB admin]({{TRAFFIC_HOST1_8088}})

login details:

- System	:PostgreSQL
- Server	:postgres1
- Username	:root
- Password	:1234
- Database	:tfstate


WIP: i believe the db is already created - just no tables yet
```sql
CREATE DATABASE terraform_state;
```

---

### Phase 3: Terraform Example
Create a folder and a file named `main.tf`. This configuration does two things: 
1.  **Backend:** Stores the state in your local Postgres.
2.  **Provider:** Connects to Vault to create a "Secret."

```hcl
terraform {
  # 1. State Storage in Postgres
  backend "pg" {
    # Replace with your actual Postgres credentials/IP
    conn_str = "postgres://root:1234@localhost/tfstate?sslmode=disable"
  }

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    }
  }
}

# 2. Key Vault Connection
provider "vault" {
  address = "http://localhost:8200"
  token   = "learn-token"
}

# Enable KV engine (usually disabled by default in fresh builds)
resource "vault_mount" "kvv2" {
  path        = "mysecret"
  type        = "kv-v2"
  description = "My local secret store"
}

# Create a test secret
resource "vault_kv_secret_v2" "example" {
  mount = vault_mount.kvv2.path
  name  = "test-creds"
  data_json = jsonencode({
    username = "admin",
    password = "super-secret-password"
  })
}
```{{copy}}

---

### Phase 4: The Test Flight

1.  **Initialize:**  
 `terraform init`{{exec}}  
    *If successful, check your Postgres `terraform_state` database. You’ll see a new table named `terraform_remote_state`.*

2.  **Plan & Apply:**
 `terraform apply -y`{{exec}}  


3.  **Verify in Vault:**
    Go back to your browser at `http://localhost:8200`. Click on **Secrets** -> **secret/** -> **test-creds**. You should see your username and password stored securely.

---

### Troubleshooting Tips for Local Labs:
* **Networking:** If Terraform is running on your host and Postgres is in Docker, use `localhost`. If Terraform is *also* inside a container, you’ll need to use the Docker network bridge IP or `host.docker.internal`.
* **Persistence:** Remember that `vault-dev` is in-memory. If you restart the container, all secrets are gone. This is actually a great "feature" for training because you can start fresh every time by just re-running `terraform apply`.

Does your Postgres instance use a custom port or a specific schema I should account for in the connection string?


## Access/test Postgress and Vault UI's


## install a specific version of terraform

- consider:
- tf version
- providers and their versions  https://registry.terraform.io/providers/hashicorp/null
- backend
- tf cloud



#### install the update, keys and tools

`apt update`{{execute}}

`apt install -y jq tree`{{exec}}





Lets move over to our terraform project

`cd mytf`{{exec}}


## setting debug level

https://developer.hashicorp.com/terraform/internals/debugging

You can set TF_LOG to one of the log levels (in order of decreasing verbosity) 
- JSON, 
- TRACE, 
- DEBUG, 
- INFO, 
- WARN or 
- ERROR 
to change the verbosity of the logs. To send the logs to a file, use TF_LOG_PATH

`export TF_LOG=INFO`{{copy}}

## 3rd party SCA tools

We'll be using some 3rd party tools, to improve the tf experience/process, for even more tools/resouces, checkout: 

https://github.com/shuaibiyy/awesome-terraform


#### Checkov

Checkov is an open-source static analysis tool that scans Terraform code to identify and highlight potential security and compliance issues. It's runs with Python, but we'll be using the docker version.

https://github.com/bridgecrewio/checkov


Me sure to be in your terraform directory

`cd ~\mytf`{{exec}}

```bash
docker run -v $(pwd):/tf bridgecrew/checkov -d /tf
```{{exec}}

This command mounts the current directory (`$(pwd)`) as a volume inside the container and runs Checkov (`bridgecrew/checkov`) on the mounted directory (`/tf`). This allows Checkov to scan the Terraform files in the current directory and provide the analysis results.

### tftui - https://github.com/idoavrah/terraform-tui

WIP Looks like this is abondoned

tftui is a simple gui for exploring terraform state.

`python3.9 -m pip install --upgrade tftui`{{exec}}

### tfsec

TFSec is a command-line tool that scans Terraform code to detect security vulnerabilities and provide recommendations for improving the security posture of your infrastructure-as-code.

https://github.com/aquasecurity/tfsec

WIP looks like now part of trivy - test

`cd ~/mytf`{{exec}}

`docker run --rm -it -v "$(pwd):/src" aquasec/tfsec /src`{{execute}}

## Graph

lets generate a terraform graph

we'll need to inside a package `apt install graphviz -y`{{execute}}

We'll first dump out the json graph, and convert to a graphic

`terraform graph`{{execute}}

`terraform graph | dot -Tpng > graph.png`{{execute}}

and we can run a quick docker container to view it

`docker run  -d -p 8090:80 -v $(pwd):/usr/share/nginx/html nginx`{{execute}}


[ACCESS GRAPH]({{TRAFFIC_HOST1_8090}}/graph.png)