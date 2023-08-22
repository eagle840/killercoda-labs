# initial setup


Start a postgress database to store the terraform backend.   
`docker-compose up -d`{{exec}}

## install a specific version of terraform

- consider:
- tf version
- providers and their versions  https://registry.terraform.io/providers/hashicorp/null
- backend
- tf cloud



#### install the update, keys and tools

`apt update`{{execute}}

`apt install -y jq tree`{{exec}}



## Using tfenv to control tf versioning

Instead of installing terraform directly, we'll install a helper tool 'tfenv'

https://github.com/tfutils/tfenv

`git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv`{{exec}}

`echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile`{{exec}}

`ln -s ~/.tfenv/bin/* /usr/local/bin`{{exec}}

`tfenv`{{exec}}

`tfenv list-remote | grep 1.3`{{exec}}


`tfenv install 1.3.9`{{exec}}

`tfenv use 1.3.9`{{exec}}

`terraform version`{{exec}}


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

export TF_LOG=INFO

## 3rd party SCA tools

We'll be using some 3rd party tools, to improve the tf experience/process, for even more tools/resouces, checkout: 

https://github.com/shuaibiyy/awesome-terraform

Many of the tools use python, so lets update that first:

```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.9
python3.9 --version 
```{{exec}}

#### Checkov

Checkov is an open-source static analysis tool that scans Terraform code to identify and highlight potential security and compliance issues.

https://github.com/bridgecrewio/checkov

`pip install checkov`{{execute}}

`cd ~; checkov -d mytf`{{exec}}

Or run it through dock:

```bash
docker run -v $(pwd):/tf bridgecrew/checkov -d /tf
```

This command mounts the current directory (`$(pwd)`) as a volume inside the container and runs Checkov (`bridgecrew/checkov`) on the mounted directory (`/tf`). This allows Checkov to scan the Terraform files in the current directory and provide the analysis results.

### tftui - https://github.com/idoavrah/terraform-tui

tftui is a simple gui for exploring terraform state.

python3.9 -m pip install --upgrade tftui

#### tfsec

TFSec is a command-line tool that scans Terraform code to detect security vulnerabilities and provide recommendations for improving the security posture of your infrastructure-as-code.

https://github.com/aquasecurity/tfsec

`cd ~/mytf`{{exec}}

`docker run --rm -it -v "$(pwd):/src" aquasec/tfsec /src`{{execute}}

## Graph

lets generate a terraform graph

we'll need to inside a package `apt install graphviz -y`{{execute}}

`terraform graph | dot -Tpng > graph.png`{{execute}}

and we can run a quick docker container to view it

`docker run  -d -p 8090:80 -v $(pwd):/usr/share/nginx/html nginx`{{execute}}


[ACCESS GRAPH]({{TRAFFIC_HOST1_8090}}/graph.png)