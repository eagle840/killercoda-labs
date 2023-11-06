an example Makefile that demonstrates conditionals and loops in a Docker context:

```
# Define variables
IMAGE_NAME = my_image
CONTAINER_NAME = my_container
PORT = 8080
ENVIRONMENT = development

# Define targets and dependencies
build: Dockerfile
	docker build -t $(IMAGE_NAME) .

run: build
ifeq ($(ENVIRONMENT), production)
	docker run --name $(CONTAINER_NAME) -p $(PORT):$(PORT) -e NODE_ENV=production $(IMAGE_NAME)
else
	docker run --name $(CONTAINER_NAME) -p $(PORT):$(PORT) $(IMAGE_NAME)
endif

stop:
	docker stop $(CONTAINER_NAME)

clean: stop
	docker rm $(CONTAINER_NAME)
	docker rmi $(IMAGE_NAME)

logs:
	docker logs -f $(CONTAINER_NAME)

test:
	docker run --rm $(IMAGE_NAME) npm test

deploy:
	for server in $(SERVERS); do \
		echo "Deploying to $$server"; \
		ssh $$server "docker pull $(IMAGE_NAME) && docker stop $(CONTAINER_NAME) && docker rm $(CONTAINER_NAME) && docker run -d --name $(CONTAINER_NAME) -p $(PORT):$(PORT) $(IMAGE_NAME)"; \
	done
```

In this Makefile:

1. We define four variables, `IMAGE_NAME`, `CONTAINER_NAME`, `PORT`, and `ENVIRONMENT`, which will be used to specify the name of the Docker image, container, port number, and environment, respectively.

2. We define six targets: `build`, `run`, `stop`, `clean`, `logs`, `test`, and `deploy`. The `build` target depends on the `Dockerfile` and will build the Docker image using the Dockerfile in the current directory. The `run` target depends on the `build` target and will run a container from the image with the specified name and port number. The `stop` target will stop the running container. The `clean` target depends on the `stop` target and will remove the container and image. The `logs` target will show the logs of the running container. The `test` target will run the tests in a new container. The `deploy` target uses a loop to deploy the image to multiple servers.

3. The `run` target uses a conditional to set the `NODE_ENV` environment variable if the `ENVIRONMENT` variable is set to `production`.

4. The `deploy` target uses a loop to deploy the Docker image to multiple servers. The `SERVERS` variable can be defined in the Makefile or passed as a command-line argument.

Note that the `deploy` target uses the `$$` syntax to escape the `$` character inside the loop. This is necessary because Make uses `$` to reference variables.