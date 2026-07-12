# spin up pytorch and jupyter

Lets pull the image:

 `docker pull pytorch/pytorch:latest  # Download latest stable image`{{execute}}

And startup the container:
 
 `docker run -it -p 8888:8888 --name pytorch-lab -v /root/:/workspace pytorch/pytorch:latest bash`{{execute}}

Inside the container, install jupyter:

`pip install jupyter`{{execute}}

Start Jupyter server:

 `jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root`{{execute}}

copy the token from the output to connect to the webserver

or directly print the token in a second terminal window:

`docker exec pytorch-lab jupyter notebook list`{{execute T2}}

connect to port 8888

{{TRAFFIC_HOST1_8888}}

and you're ready to go

Just follow the instructions in the tutorials folder

If you need some pytorch examples:

`git clone https://github.com/pytorch/tutorials.git`{{execute T2}}
