
# spin up tensorflow and juypter

Lets pull the image:

 `docker pull tensorflow/tensorflow:latest-py3  # Download latest stable image`{{execute}}

And statup the container:
 
 `docker run -it -p 8888:8888 --name dockertensor -v /root/:/tf/root tensorflow/tensorflow:latest-py3-jupyter  # Start Jupyter server`{{execute}}

 copy the token from the output to connect to the webserver

 or directly print the token in a second terminal window:

`docker exec dockertensor jupyter notebook list`{{execute T2}}

 connect to port 8888

{{TRAFFIC_HOST1_8888}}

 and you're ready to go

 Just follow the instructions in the 'tensorflow-tutorials' folder

 If you need some more tensor examples, run and they will showup in the root folder in the jupyter webpage.

`git clone https://github.com/GoogleCloudPlatform/training-data-analyst`{{execute T2}}

 