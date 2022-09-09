# Run vulnerabilities scans against images



Lets take a look at a base ubuntu image and some others.


`trivy image ubuntu:18.04`{{execute}}

`trivy image ubuntu:18.04 | grep Total`{{execute}}

`trivy image -s CRITICAL --ignore-unfixed ubuntu:18.04`{{execute}}

Lets take a look at a some other images

`trivy image centos:7.6.1810 | grep Total`{{execute}}

`trivy image debian:10.2-slim | grep Total`{{execute}}

We can take a look at a much small image and see the reduction is vulnerabilities.

`trivy image alpine:3.11`{{execute}}

and lets check the latest:

`trivy image alpine`{{execute}}

