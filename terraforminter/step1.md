# initial setup

In this lab we'll be working with Terraform and Docker to deploy a container on the localhost.

`sudo apt update`{{execute}}   

`apt install -y tree jq`{{exec}}

Start a postgress database for later use.   
`docker-compose up -d`{{exec}}


## install terraform

`curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -`{{execute}}    

`apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"`{{execute}}  


`apt install terraform`{{execute}}    

`terraform version`{{execute}}    

  

`terraform -install-autocomplete`{{execute}}    

`exec bash`{{execute}}

# Basic Setup

Some terraform file have already been created, in there own directory

`cd mytf`{{execute}}

`ls`{{execute}}

a main file, containing the provisoners and a providers file have been provided, with a var file that will set a port varible for the docker container to 8080

`terraform init`{{execute}} 

Lets look at the providers we're using the terraform command:

`terraform providers`{{exec}}

now look at the folder structure:

`tree -a`{{execute}}

You'll set a lock file, which locks down which versions you can use, and you'll see the downloaded provider in the `.terraform` folder.

`cat .terraform.lock.hcl`{{execute}}

Notice the provider and the version and constraints.

When we run 'plan' & 'apply':

`terraform plan`{{execute}}    

`terraform apply`{{execute}} 

and check the container 'tutorial' is running:

`docker ps`{{execute}}


# Terraform Output

Docs: https://www.terraform.io/language/values/outputs

Learn more: https://learn.hashicorp.com/tutorials/terraform/outputs

While the outputs declaration can appear anywhere, we'll follow best practice and create an output.tf file.

`nano output.tf`{{execute}}

```
output "ext_port" {
  description = "External port of docker container"
  value       =  resource.docker_container.nginx.ports
}
```{{copy}}

Format the tf files, which 'cleans' up the formatting, the command will show which files it cleaned:   
`terraform fmt`{{execute}}

Validate the tf files, which does need 'init' before using:   
`terraform validate`{{execute}}

Lets change the port used, using an argument override

`terraform plan -var="port=8090"`{{execute}}


This time we run the apply, you'll see the added 'output'   
`terraform apply -var="port=8090"`{{execute}}

check docker for the 'tutorial' container using port 8090:

`docker ps`{{execute}}

We can now query the output held in the state file:

`terraform output`{{execute}}

Lets dump out a set of values in json (using jq)

`terraform output -json ext_port | jq`{{execute}}

Starting with version 0.14, Terraform wraps string outputs in quotes by default. You can use the -raw flag when querying a specified output for machine-readable format.,,   also -json


sensitive   = true

## Setting variables

Terraform can take variables from several locations, in this order: https://www.terraform.io/language/values/variables#variable-definition-precedence

- Environment variables
- The terraform.tfvars file, if present.
- The terraform.tfvars.json file, if present.
- Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
- Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)

Lets creat a terraform.tfvars file

`nano terraform.tfvars`{{execute}}

```
port = 8070
```{{copy}}

`terraform validate`{{execute}}

`terraform apply`{{execute}}

Note the the default value in the var.tf file has been over written my the tfvars value.

we can always over ride this using the -var argument when using plan/apply



   
