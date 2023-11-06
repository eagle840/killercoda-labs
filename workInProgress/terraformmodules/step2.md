# steps

`cd ~\mytf`{{exec}}

## setup provider

in this example we are going to use a 'null provider' - a provider that has resourse types that basiclyy do nothing. Goto https://registry.terraform.io/providers/hashicorp/null/3.2.1 and click on the 'use provider' button and you'll get the code:

`cat providers.tf`{{exec}}

You'll see we've coded as a required provider, and coded a provide block for  Configuration options - in this case there are none.


Now lets look at the documentation, to select a resource on the left hand side, there is only one 'null_resource'. 

we'll recreate the following resource:

```
resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  # triggers = {
  #   cluster_instance_ids = join(",", aws_instance.cluster.*.id)
  }
```
 `nano ymtf/main.tf`{{exec}}

 and add the resorse block above.

# cmd

Lets format it and validate it

`terraform fmt`{{fmt}}

We'll need to init terraform before running the validate command

`terraform init`{{exec}}

`tf validate`{{exec}}


# add some json stuff

We've added a json file

### direct

`nano direct.tfvars.json`{{exec}}

```
{
  "environment_name": "dev"
}
```

We can access these variable with 'var.enviroment_name`

### indirect

`nano vars.json`{{exec}}

```
{
  "cidr_block": "192.169.1.0/24",
  "image": "nginx"
}
```

```
locals {
  net1 = jsondecode(file("./vars.json"))["cidr_block"]
  image = jsondecode(file("./vars.json"))["image"]
  vars = jsondecode(file("./vars.json"))
}
```


lets init the config to load it in WIP it is just init? or apply?

`terraform init`{{exec}}

we can now do a validate:

`terraform validate`{{exec}}

add a locals.tf file, now how we imported a single item, vs the whole object:




# console

https://prefetch.net/blog/2020/04/27/using-the-terraform-console-to-debug-interpolation-syntax/  <= way out of date

`terraform console`{{exec}}

`type(["a","b"])`{{exec}}

`type(tolist(["a","b"]))`{{exec}}

look at the json items we brought in:

`local.image`{{exec}}

and the whole json object:


`local.vars`{{exec}}

and a single item from the json object:

`local.vars.cidr_block`{{exec}}

use the name (dot notation) of any resource/data and it'll return the json data

for more functions see https://developer.hashicorp.com/terraform/language/functions

# locals

where var's can't be changed with tf is running, locals can be

# conditionls

condition ? true_val : false_val

# functions#

# for loop

  tags = {
    for key, value in var.ec2_tags :
    key => lower(value)
  }
}


