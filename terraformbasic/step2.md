# Setup a docker container with Terraform


`mkdir learn-terraform-docker-container`{{execute}}    

`cd learn-terraform-docker-container`{{execute}}   

`nano main.tf`{{execute}}   

copy the code below

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


## Graph

lets generate a terraform graph

we'll need to inside a package `apt install graphviz -y`{{execute}}

`terraform graph | dot -Tpng > graph.png`{{execute}}

and we can run a quick docker container to view it

`docker run  -d -p 8090:80 -v $(pwd):/usr/share/nginx/html nginx`{{execute}}


[ACCESS GRAPH]({{TRAFFIC_HOST1_8090}})

## code

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



