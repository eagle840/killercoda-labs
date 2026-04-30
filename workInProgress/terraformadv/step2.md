# steps






# Step 2: Complex Data Logic (Loops & Dynamic Blocks)

In production, you rarely hardcode every single attribute. Advanced Terraform users pass complex data objects (like JSON or YAML) into their configurations and use logic to map that data to resources.

In this step, we will transform a raw JSON file into dynamic configuration for a Helm release.

## 1. Prepare the Advanced JSON Data

We want to control our Nginx deployment via an external `vars.json` file. Let's update the existing file with a map of Helm settings.

`nano ~/mytf/vars.json`{{exec}}
  
  Replace the contents with this more complex structure:
  {
    "app_name": "nginx-advanced",
    "labels": {
      "tier": "frontend",
      "managed-by": "terraform",
      "team": "devops"
    },
    "helm_settings": {
      "service.type": "NodePort",
      "replicaCount": "2",
      "service.port": "80"
    }
  }

  `{{copy}}

  2. Implement JSON Parsing and Dynamic Blocks

  Now we need to update main.tf. We will use:
   1. jsondecode: To read the file.
   2. for loops: To transform the labels map into a Kubernetes-friendly format.
   3. dynamic blocks: To iterate over helm_settings and create multiple set blocks inside our Helm resource.

  `nano ~/mytf/main.tf`{{exec}}

  Update the file to match this logic:

```
   1 locals {
   2   vars = jsondecode(file("${path.module}/vars.json"))
   3 }
   4
  resource "kubernetes_namespace" "namespace" {
    metadata {
      name = local.vars.app_name
  Using a 'for' loop to generate labels
      labels = {
        for k, v in local.vars.labels : k => upper(v)
      }
    }
  }

  resource "helm_release" "nginx_app" {
    name       = local.vars.app_name
    repository = "https://charts.bitnami.com/bitnami"
    chart      = "nginx"
    namespace  = kubernetes_namespace.namespace.metadata[0].name

  The Dynamic Block: Iterates over the helm_settings map in JSON
    dynamic "set" {
      for_each = local.vars.helm_settings
      content {
        name  = set.key
        value = set.value
      }
    }
  }

  ```{{copy}}

  3. Explore Logic in the Terraform Console

  Before applying, let's use the Terraform Console to test our data transformations. This is a critical debugging step for advanced HCL.

  `cd ~/mytf && terraform init`{{exec}}

  Open the console:
  `terraform console`{{exec}}

  Try these commands to see how Terraform interprets your logic:

  View the decoded JSON object:

  `local.vars`{{copy}}

  Test a 'for' loop to filter labels (only get labels starting with 't'):
  `{ for k, v in local.vars.labels : k => v if substr(k, 0, 1) == "t" }`{{copy}}

  Calculate the NodePort based on the port in JSON (adding an offset):
  `tonumber(local.vars.helm_settings["service.port"]) + 30000`{{copy}}

  Type exit to leave the console.

  4. Apply and Validate

  Now, apply the configuration. Notice how Terraform handles the creation of the Namespace and the Helm release simultaneously.

  `terraform apply -auto-approve`{{exec}}

  Validate that the dynamic settings were applied:

  Check the Namespace labels (should be uppercase):
  `kubectl get ns nginx-advanced --show-labels`{{exec}}

  Check the Helm deployment values:

---




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




# console WIP move to step 3 

Merge the below into tf imedicate lab

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


