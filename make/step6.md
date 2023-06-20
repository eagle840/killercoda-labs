an example Makefile that demonstrates how to define and use variables in a Makefile:

```
# Define variables
APP_NAME = my_app
APP_VERSION = 1.0.0
APP_PORT = 8080
APP_ENV = development

# Define targets and dependencies
build:
	docker build -t $(APP_NAME):$(APP_VERSION) .

run: build
	docker run --name $(APP_NAME) -p $(APP_PORT):$(APP_PORT) -e NODE_ENV=$(APP_ENV) $(APP_NAME):$(APP_VERSION)

stop:
	docker stop $(APP_NAME)

clean: stop
	docker rm $(APP_NAME)
```

In this Makefile:

1. We define  variables at the top of the Makefile using the `VARNAME = value` syntax. In this case, we define variables for the `APP_NAME`, `APP_VERSION`, `APP_PORT`, and `APP_ENV`.

2. We define three targets: `build`, `run`, `stop`, and `clean`. The `build` target builds a Docker image using the `APP_NAME` and `APP_VERSION` variables. The `run` target runs a container from the image with the specified name, port, and environment variables. The `stop` target stops the running container. The `clean` target stops and removes the container.

3. The variables are used throughout the Makefile using the `$(VARNAME)` syntax. For example, `$(APP_NAME)` is used to specify the name of the Docker image and container.

By defining variables at the top of the Makefile, we can easily change the values of these variables without having to modify the commands in the targets. This makes it easier to manage and maintain the Makefile for different environments and configurations.