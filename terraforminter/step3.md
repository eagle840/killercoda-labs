# Terraform Workspaces

lets make a few adjustments so we can add a 2nd container:   

Add:

`nano var.tf`{{execute}}

```
variable "container_name" {
  type        = string
  description = "enter the container name"
}
```{{copy}}

add update ***var.container_name*** in 

`nano main.tf`{{execute}}

```
resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = var.container_name
  ports {
    internal = 80
    external = var.port
  }
}
```{{copy}}



you'll notice that the docker container will have running will be replaced.

We'll create a new workspace


`terraform workspace list`{{execute}}

`terraform workspace new ws2`{{execute}}

`terraform workspace list`{{execute}}

Notice the workspace we're using is marked with a *

`terraform apply "myplan.tfplan"`{{execute}}   # it won't work, so create a new plan

`terraform plan -out=myplan.tfplan`{{execute}}

since we didn't provide a name in the var file, it will prompt us for one, use `nginx1`

`terraform apply "myplan.tfplan"`{{execute}}

`docker ps`{{execute}}  

Lets take a look at the tree structure, and you'll see an added folder for the workspace: `./terraform.tfstate.d/ws2`  

`tree -a`{{execute}}

take note where the orginal (default) tf state was stored, and where the new ws2 state is stored
 

`docker ps`{{execute}}

and finally lets kill  the running containers

`docker kill $(docker ps -q)`{{execute}}

WIP:
- terraform destroy (you can't use a plan, so you have to remember varibles you entered)
- delete ws2 workstate
- LINK TO the page running httpd
- add the index.thml to the httpd container

 