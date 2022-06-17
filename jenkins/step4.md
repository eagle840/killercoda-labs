# set a job to use this agent

Start a new item/job.   
Open your job configuration and click 'Restrict where this project can be run' in the General section, and set it to 'Agent' ,  the same label we gave it earlier - (you should see 'Label agent matches no nodes and 1 cloud. Permissions or other restrictions provided by plugins may further reduce that list' shown directly under the Label field)

Click 'save'


If your job doesn't start make sure that you have enabled the node cloud template from step 3.

You can also see the docker activity in the Jenkins System Log (manage jenkins > Status Info > System Log)

# Select your docker image for the task at hand

in this tutorial we used the jenkins image we orginally pulled down, but you can rebuild the jenkins image to add the programs/features you need


