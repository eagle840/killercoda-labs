# Test the set

Lets take a look and the PV's and PVC's

`k get pv,pvc`{{execute}}

and the deployed resources

`k get all`{{execute}}

Take a note of the claims in the PV's and the pods shown.


and delete one of the pods, and see it come back and claim the same pv

Lets connect to one of the pods create a  file

`k exec -it nginx-sts-1 -- /bin/sh`{{execute}}

can create a file

`cd /var/www; touch vip.html; ls`{{execute}}

exit out of the session

`exit`{{execute}}

Lets delete the pod

`k get pods`{{execute}}

`k delete pod nginx-sts-1`{{execute}}

`k get pods`{{execute}}

Note the deleted pod is quickly recreated.

and in a few moments you'll see it recreated with the same pv, pvc

And the VIP file is still present.

`k exec -it nginx-sts-1 -- /bin/sh`{{execute}}

`ls /var/www`{{execute}}

`exit`{{execute}}

And finally we'll scale the set down to zero and delete it.

`k scale --replicas=0 sts/nginx-sts`{{execute}}

You can see the pods closing down one by one

`k get pods`{{execute}}

And delete the sts:

`k delete sts nginx-sts`{{execute}}

But the PV's,  PVC's, and service are still in the system.

`k get pv,pvc,service`{{execute}}




