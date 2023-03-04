## move terraform state to a database

In this last step, we'll move the state over to a postgres database.

Edit the providers.tf to match:

`nano providers.tf`{{exec}}

```sh
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
  backend "pg" {
    conn_str = "postgres://root:1234@localhost/tfstate?sslmode=disable"
  }
}
```{{copy}}

and run 

`terraform init`{{exec}}

Terraform will prompt you to move the state to the backend postgres database

And you have now stored your state on the postgres backend.


for those that are interested, you can connect to 'adminer' docker container on port 8088 {{TRAFFIC_HOST1_8088}} and view the sql db with the terraform data:

login details:

- System	:PostgreSQL
- Server	:postgres1
- Username	:root
- Password	:1234
- Database	:tfstate
