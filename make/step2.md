# Hello World! using python



an example Makefile that uses Docker commands and resources:

```
# Define variables
IMAGE_NAME = my_image
CONTAINER_NAME = my_container

# Define targets and dependencies
build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run --name $(CONTAINER_NAME) $(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME)

clean:
	docker rm $(CONTAINER_NAME)
	docker rmi $(IMAGE_NAME)
```

In this Makefile:

1. We define two variables, `IMAGE_NAME` and `CONTAINER_NAME`, which will be used to specify the name of the Docker image and container, respectively.

2. We define four targets: `build`, `run`, `stop`, and `clean`. The `build` target will build the Docker image using the Dockerfile in the current directory. The `run` target will run a container from the image with the specified name. The `stop` target will stop the running container. The `clean` target will remove the container and image.

3. Each target has a set of commands that use the Docker commands to build, run, stop, or remove the Docker resources.