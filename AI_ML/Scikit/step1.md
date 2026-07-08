
# spin up tensorflow and juypter


And statup the container:
 
 `docker run -it -p 8888:8888 --name dockertensor -v /root/:/tf/root tensorflow/tensorflow:latest-py3-jupyter  # Start Jupyter server`{{copy}}

 `docker run -it -p 8888:8888 --name docker-ds -v /root/:/home/jovyan/work jupyter/datascience-notebook:latest`{{exec}}

 copy the token from the output to connect to the webserver

 or directly print the token in a second terminal window:

`docker exec dockertensor jupyter notebook list`{{execute T2}}

 connect to port 8888

{{TRAFFIC_HOST1_8888}}

 and you're ready to go

 ## Use A Juypter Note Book to download

 `!git clone https://github.com/ageron/handson-ml3.git`{{copy}}

 And follow the labs!

 Just follow the instructions in the 'tensorflow-tutorials' folder

 If you need some more tensor examples, r

`git clone https://github.com/GoogleCloudPlatform/training-data-analyst`{{copy}}

 