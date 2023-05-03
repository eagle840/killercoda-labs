# hello




### CA server - simple (via file tx)

### certicate chaining

https://www.sslshopper.com/SSL-CHECKER.HTML



### ACME  

https://en.wikipedia.org/wiki/Automatic_Certificate_Management_Environment

https://www.rfc-editor.org/rfc/rfc8555

### Smallstep CA

https://smallstep.com/docs/tutorials/docker-tls-certificate-authority

https://hub.docker.com/r/smallstep/step-ca

docker run -d -v step:/home/step \
    -p 9000:9000 \
    -e "DOCKER_STEPCA_INIT_NAME=Smallstep" \
    -e "DOCKER_STEPCA_INIT_DNS_NAMES=localhost,$(hostname -f)" \
    smallstep/step-ca

https://www.youtube.com/watch?v=4ET20bCsTX0

- https://i12bretro.github.io/tutorials/0746.html
- https://github.com/smallstep/certificates

# OTHER

### https with python

https://realpython.com/python-https/

### videos

https://www.youtube.com/watch?v=25_ftpJ-2ME
David Bombal and Ed Harmoush




blog 
https://karneliuk.com/2021/02/sec-3-building-your-own-containerised-pki-root-ca-with-linux-and-docker-to-simplify-and-secure-network-automation/

https://karneliuk.com/2021/03/sec-4-complete-guide-for-integrating-nokia-arista-cumulus-as-well-as-centos-and-raspberry-pi-linux-in-your-own-pki/

