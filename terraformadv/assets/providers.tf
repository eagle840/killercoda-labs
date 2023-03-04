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

provider "docker" {}