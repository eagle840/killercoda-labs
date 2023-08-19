#  Adding vars file


Lets create another file var.tf that includes our variables

`nano var.tf`{{execute}}

in this first file, it will ask for the port number when tf plan/apply is run



```sh
variable "port" {
  type = number
}
```{{copy}}

and change the main.tf to include the variable in the external port number

```sh
  ports {
    internal = 80
    external = var.port
  }
```{{copy}}

when you run terraform apply it will ask for a port number. Give it the port number 8080

`terraform apply`{{execute}}

lets check that the docker port has been ajusted:
`docker ps`{{execute}}

## Using command line arugments for variables

`terraform plan -var="port=8084"`{{execute}}

## Using environment variables

you set set environment variables for terraform:

`export TF_VAR_port=8083`{{execute}}

running `terraform plan`{{execute}} you'll see that terraform has picked up that variable


## Using a .tfvars file

We can include that port varible in a tfvar yaml file for terraform to pick up.

`nano test.tfvars`{{execute}}

```
port=8085
```{{copy}}

`terraform plan -var-file=test.tfvars`{{execute}}

## Using a plan

You'll notice that terraform states you can create a terraform plan file with the -out argument.

`terraform plan -var-file=test.tfvars -out plan.tfplan`{{execute}}

`ls`{{execute}}

we can now use that file, with the varaibles included to execute an 'apply' without having to require varaiables again

`terraform apply plan.tfplan`{{execute}}

You can always review a plan file with 'terraform show <plan file>'

`terraform show myplan.tfpan`{{exec}}

## Documentation on variables

https://www.terraform.io/language/values/variables

# Destroy the environment

and finally we'll destroy the infrastructure

`terraform destroy`{{execute}}




