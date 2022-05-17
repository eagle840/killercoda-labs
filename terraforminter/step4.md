# modules

In terraform, a 'resource' is part of a 'provider', for example, for the docker provider, we  can see what resources we can use my looking at that resources docs [Docker Provider](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs) - in the left hand side you can expand out the list of resources.

In this section will create a local custom type of resource called a module, which it's self can use other modules and resources. "Modules are self-contained packages of Terraform configurations that are managed as a group."

WIP
- create a docker nginx container, and generated a tf doc for the module it's self


The Terraform repo contains an extensive collections of [modules](https://registry.terraform.io/browse/modules) that have been uploaded, but you can store modules in many other places.

To learn even more see the module learning docs: https://learn.hashicorp.com/tutorials/terraform/module?in=terraform/modules


We'll create a folder to store the modules:  

`terraform workspace new ws3`{{execute}}

`cd ~/mytf`{{execute}}

`mkdir modules`{{execute}}

`cd modules`{{execute}}


and create a new module(folder) called 'nginxsite', just a simple webserver, with a static html file:   
`mkdir httpdsite`{{execute}}

`cd httpdsite`{{execute}}

A typical module will contain:

```
.
├── LICENSE
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
```

# create module   -- JUST KEEP TE nginx container in the main for now

WIP `nano httpdsite.tf`

```
code
```

# specify providers used

even though the provider is supplied in the root folder, we need to specify the providers needed:

`nano providers.tf`{{execute}}

```
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}
```

# create a file for the website

`nano index.html`{{execute}}   

add the code:
```
<!DOCTYPE html>
<html>
    <head>
        <title>Example</title>
    </head>
    <body>
        <p>Hello world!</p>
    </body>
</html>
```

`nano pagesource.tf`{{execute}}   
```
resource "local_file" "index" {
    content     = "Index"
    filename = "${path.module}/index.html"
}
```

`nano httpcontainer.tf`{{execute}}

```
resource "docker_image" "httpd" {
  name         = "httpd:latest"
  keep_locally = false
}

resource "docker_container" "httpd" {
  image = docker_image.httpd.latest
  name  = "httpdcontainer"
  ports {
    internal = 80
    external = 80
  }
}
```

???? is the provider needed in the module -- I think it is - test it

# Call a module

in the main root tf file, you'll call a module, using the `module` keyword


```
`module "anyName" {
    source = "<path>/folder"
    variable = value #the variables in the varibles.tf file
    #any variables left out, will be requested for
}

```
`cd ~/mytf`{{execute}}

change the main.tf file to include the module:

`nano main.tf`{{execute}}

```
module "mywebpage" {
    source = "./modules/httpdsite" 
}
```

Because this is an added module/resource, we can rerun init, or get to install the modules/providers

`terraform init`{{execute}}


Running plan will now show the added module/file
`terraform plan`{{execute}}


Notice that the plan is asking for a container name, lets add an output to the module to supply the container name

`cd ./modules/httpdsite`{{execute}}

`terraform apply`{{execute}}

You'll now see the index.html added to the module directory

`tree`{{execute}}



# add the resource into the contain binding volume

https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container

------------------------------

Pulling output from  module.

In the resource you want to use a module output

    syntax: module.<MODULE NAME>.<OUTPUT NAME>

    x = module.<y1>.<y2>

y1: is the name of the module you called it in the root tf foleder
y2: is the outputname you used in the <module>.<var> 
--------------------------------
If the module is actually in the terraform repo, you'll use the name of the module instead of <path> , you'll also have to include a key=value for the version number.

https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file


In the main stack, if you want to use the output of a module
EG:


```
resource "aws ebs" "main" {
    instance = module.anyName.<varible_name>
}
```