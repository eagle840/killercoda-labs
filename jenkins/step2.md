

## create and check a job

'create a job' in the center section, give it a name (eg testjob) and select 'Freestyle project', then 'ok'
'create a freestyle job

Scroll down to Build, and 'add build step'/Execute shell  and enter 'date'  and 'save'

now click 'Build now' in the LHS, and below that you'll see the Build History populate

Click on the item and then 'Console Output' and you'll see that 'date' was executed 

# Check the Jenkins folder layout

lets take a quick poke around in the jenkins folder (connected to the jenkins container)


`tree ./jenkins/jobs`{{execute}}

and you'll see the job we just created.





