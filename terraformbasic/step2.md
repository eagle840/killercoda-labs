# Setup a docker container with Terraform


`mkdir learn-terraform-docker-container`{{execute}}    

`cd learn-terraform-docker-container`{{execute}}   

`nano main.tf`{{execute}}   

Terraform will process all .tf file in the current working directory 

copy the code below
```

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}



provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}

```{{copy}}

## Terraform Workflow


Initiate Terraform, which includes downing any provides.

`terraform init`{{execute}}  

Plan the envirnoment

`terraform plan`{{execute}} 

And apply it

`terraform apply`{{execute}}    

note the new terraform state file, a json file

`tree`{{execute}}

we can list the components,

`terraform state list`{{execute}}

or get a full description of one of the compoents,

`terraform state show docker_image.nginx`{{execute}}

check running containers      
`docker ps`{{execute}}   

and access  the web page

[ACCESS NGINX]({{TRAFFIC_HOST1_8000}})




