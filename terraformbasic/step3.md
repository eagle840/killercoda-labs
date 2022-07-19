# breaking the file up

Lets make this easier to read by breaking the single file into multiple

create a providers.tf file to just include a set of providers:

`nano providers.tf`{{execute}}

```sh
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}
```{{copy}}

create a main block for the main terraform resources, ie remove the provider section so that all your have left is:

`nano main.tf`{{execute}}

```sh
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
```{{copy}}

Now when you run terraform commands, it will run all the files in this folder.

`terraform plan`{{execute}}    

`terraform apply`{{execute}}    

In this case there are no changes




