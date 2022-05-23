#  adding vars file

see: https://www.terraform.io/docs/language/values/variables.html

lets create another file var.tf that includes our variables

`nano var.tf`{{execute}}

in this first file, it will ask for the port number when tf plan/apply is run



```
variable "port" {
  type = number
}
```

and change the main.tf to include the variable in the external port number

```
  ports {
    internal = 80
    external = var.port
  }
```

when you run terraform apply it will ask for a port number. Give it the port number 8080

`terraform apply`{{execute}}

lets check that the docker port has been ajusted:
`docker ps`{{execute}}

## using command line arugments for variables

`terraform plan -var="port=8084"`{{execute}}

## using environment variables

you set set environment variables for terraform:

`export TF_VAR_port=8083`{{execute}}

running `terraform plan`{{execute}} you'll see that terraform has picked up that variable


## using a .tfvars file

we can include that port varible in a tfvar file for terraform to pick up

`nano test.tfvars`{{execute}}

```
port=8085
```

`terraform plan -var-file=test.tfvars`{{execute}}

You'll notice that terraform requested and out put file

`terraform plan -var-file=test.tfvars -out plan.tfplan`{{execute}}

`ls`{{execute}}

we can now use that file, with the varaibles includes to execute an 'apply' without having to require varaiables again

`terraform apply plan.tfplan`{{execute}}

## Documentation on variables

https://www.terraform.io/language/values/variables

# Destroy the environment

and finally we'll destroy the infrastructure

`terraform destroy`{{execute}}




