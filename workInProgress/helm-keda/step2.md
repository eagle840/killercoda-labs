
# Lets increase the load:

In a second terminal:


`kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"`{{ execute T1 }}


wait a minute and then check the status of the HPA and return to the orginal terminal

`kubectl get hpa`{{execute}} 

and the number of pods on the deployment

`kubectl get deployment php-apache`{{execute}}


check the node status

`kubectl describe node node01`{{execute}}



# Stop the load

Return to the second terminal and terminate the program using <ctrl>+c






