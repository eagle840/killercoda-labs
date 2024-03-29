STep 4


an example Makefile that demonstrates variables in a Docker context:

```
# Define variables
IMAGE_NAME = my_image
CONTAINER_NAME = my_container
PORT = 8080

# Define targets and dependencies
build: Dockerfile
	docker build -t $(IMAGE_NAME) .

run: build
	docker run --name $(CONTAINER_NAME) -p $(PORT):$(PORT) $(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME)

clean: stop
	docker rm $(CONTAINER_NAME)
	docker rmi $(IMAGE_NAME)
```

In this Makefile:

1. We define three variables, `IMAGE_NAME`, `CONTAINER_NAME`, and `PORT`, which will be used to specify the name of the Docker image, container, and port number, respectively.

2. We define four targets: `build`, `run`, `stop`, and `clean`. The `build` target depends on the `Dockerfile` and will build the Docker image using the Dockerfile in the current directory. The `run` target depends on the `build` target and will run a container from the image with the specified name and port number. The `stop` target will stop the running container. The `clean` target depends on the `stop` target and will remove the container and image.

3. Each target has a set of commands that use the Docker commands to build, run, stop, or remove the Docker resources. The variables are used to specify the image name, container name, and port number.

Note that the `run` target uses the `-p` flag to map the host port to the container port, which is specified by the `PORT` variable.