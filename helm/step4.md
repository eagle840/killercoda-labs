# GENERATE FROM SCRATCH


### Bare Tempate

`cd ~`{{execute}}

`helm create my-app`{{execute}}

`cd my-app`{{execute}}

lets remove files we will use from scratch

`rm ./templates/*`{{execute}}

```
echo "" > values.yaml
``` {{execute}}

### Sample Template

lets get a template from https://k8syaml.com/, just copy the default template will be fine. (you can remove the pod affinity if you wish. Use the copy function in the top right)

can paste it into the templates folder

`nano ./templates/app.yaml`{{execute}}

Now since there is no templating, the yaml file generated will only have comments inserted

`helm template .`{{execute}}

### Add a value for the template

`echo  "replicas:2 " >> values.yaml`{{execute}}

and in the template/app.yaml file, change the replicas line to {{.Values.replicas}}


`nano ./templates/app.yaml`{{execute}}

and lets see the generated output:

`helm template .`{{execute}}

For more on templating, see https://helm.sh/docs/chart_template_guide/getting_started/


### debugging

When you run the `helm template .` command, you may recieve an error. You can add the `--debug` argument and the output will show what yaml files in the templated folder have been processed, and the the error that it was run into with the related yaml file - You can ignore the Go stack trace.

It is important to note that the processor will not process files that start with an underscore(_).


### pipelines and functions

One of the things that Go/Helm templating can do is provide piping (as in Bash) and functions.

for example, if you used the values.yaml file to define a web-app name, you could make sure that the name was converted into lower case:

`{{ .Values.webappname | lower }}`

for a full function list for Helm see https://helm.sh/docs/chart_template_guide/function_list/

Their is also 'if' functionality (prefix -notation):

`{{if eq .Values.environment "dev"}}-dev{{ end }}`


### Named/partial templated

Files that are stored in the template folder that start with underscore, and end with .tpl. (EG _my-template-1.tpl). 

In this file, you'll define a Go template block, 'define' with the piece of template that you want to reuse in the regular yaml templated files.

```
{{ define "my-temp1" }}
   - name: nginx
     imagine

{{ end }}
```

In the regular template file, use {{ include . }}  (or the less functional {{ template . }} )
The dot is the hierachal level in the values file to use. (see Helm Docs). You'll also need a indent function, since Go templating does not care with in the line you put the 'include'. 


```
{{ include  "my-temp1" . | indent 6 }}
```

***pro tip*** use the dash to remove any white space {{-  <cmd>}}


### Update a Chart, and install

Lets make a change to the chart, and then push it to K8s


### Static Analysis

`curl https://get.datree.io | /bin/bash`{{exec}}