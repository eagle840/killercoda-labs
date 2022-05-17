## Terraform State

Lets look at the present state:

`terraform state list`{{execute}}

`docker ps`{{execute}}

We can kill the docker container:

`docker stop tutorial`{{execute}}

And you'll see it's still in the state list:

`terraform state list`{{execute}}

Runnng 'refresh' will refresh that terraform state (Warning: This command is deprecated)

`terraform refresh`{{execute}}


`terraform state list`{{execute}}

Lets put the state back to what it should me:

`terraform apply`{{execute}}

note that the command is requesting a port - we should have outputed a plan

`terraform state list`{{execute}}

## terraform taint

Terraform taint will mark an object for replacement (destroy and build) at the next plan/apply

`terraform taint docker_container.nginx`{{execute}}

(you can untaint using terraform untaint cmd)

`terraform state list`{{execute}}

Looking close at the show command, we can see that the state is marked as tainted

`terraform state show docker_container.nginx`{{execute}}

we can also review the whole stack state with

`terraform show`{{execute}}

Lets review the changes that will be applied:

`terraform plan`{{execute}}


when you run 'terraform plan' you can see in the output that the container will be replaced.

`terraform apply`{{execute}}



## using a terraform plan file

We can also create a plan file, so it can be applied directly, without having to add parameters

`terraform plan -var="port=8080" -out myplan.tfplan`{{execute}}

you can view the contents of that plan:

`terraform show myplan.tfplan`{{execute}}

and to apply that plan:

`terraform apply myplan.tfplan`{{execute}}

note that you didn't have to confirm the apply

## Functions & Console

Terraform has a range of functions: https://www.terraform.io/language/functions.

Lets open a terraform console, and try one out:

`terraform console`{{execute}}

`help`{{execute}}

`timestamp()`{{execute}}

lets discover the type of `timestamp`

`type(timestamp())`{{execute}}

lets exit out of the console `exit`{{execute}}

and add the function to our terraform output, so it stores the deployment time

`nano output.tf`{{execute}}

and add the following:

```
output "deploy_time" {
    description = "the deployement time, in utc"
    value = timestamp()
}
```{{copy}}

and validate/apply

`terraform validate`{{execute}}

`terraform apply -var="port=8090"`{{execute}}

`terraform output deploy_time`{{execute}}