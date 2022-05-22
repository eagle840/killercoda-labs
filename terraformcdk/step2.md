# Using Typescript


taken from:   
https://learn.hashicorp.com/tutorials/terraform/cdktf-install

`cd ~`{{execute}}

`mkdir learn-cdktf-docker`{{execute}}

`cd learn-cdktf-docker`{{execute}}

`cdktf init --template=typescript --local`{{execute}}

(--local saves it locally, as opposed to tf cloud)

enter a project name and description

Lets install the package for docker.

`npm install @cdktf/provider-docker`{{execute}}

For a list of available node packages for the cdk, see https://www.npmjs.com/search?q=keywords:cdktf


enter code block  cdktf.json and the ts scrip
from
https://github.com/hashicorp/terraform-cdk/tree/main/examples/typescript/docker

`rm cdktf.json`{{execute}}

`wget https://raw.githubusercontent.com/hashicorp/terraform-cdk/main/examples/typescript/docker/cdktf.json`{{execute}}

`rm main.ts`{{execute}}

`wget https://raw.githubusercontent.com/hashicorp/terraform-cdk/main/examples/typescript/docker/main.ts`{{execute}}


Lets  Generate CDK Constructs for Terraform providers and modules:

`cdktf get`{{execute}}

And deploy the stack:

`cdktf deploy`{{execute}} and approve the deployment

`docker ps`{{execute}}

And list stacks in app.

`cdktf list`{{execute}}

And finally destory it:

`cdktf destroy`{{execute}}

