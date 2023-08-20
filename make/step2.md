# Basic logic


In Makefiles, you can use various logic statements and constructs to define rules and conditions. Some commonly used logic statements in Makefiles include:

1. `ifeq` and `ifneq`: These statements are used to test equality or inequality between two variables or values. For example:

   ```make
   ifeq ($(VAR), value)
       # do something
   endif

   ifneq ($(VAR), value)
       # do something
   endif
   ```

2. `ifdef` and `ifndef`: These statements are used to check if a variable is defined or not. For example:

   ```make
   ifdef VAR
       # do something
   endif

   ifndef VAR
       # do something
   endif
   ```

3. `$(if condition, then-part, else-part)`: This function allows you to perform conditional operations based on a condition. For example:

   ```make
   result := $(if $(VAR), true, false)
   ```

4. `$(shell command)`: This function allows you to execute shell commands and capture their output. You can use it to perform complex logic or condition checks. For example:

   ```make
   result := $(shell if [ -f file.txt ]; then echo "true"; else echo "false"; fi)
   ```

5. `$(foreach var, list, text)`: This function allows you to iterate over a list and perform operations for each element. For example:

   ```make
   FILES := file1.txt file2.txt file3.txt
   $(foreach file, $(FILES), \
       $(info Processing $(file)) \
       # do something with $(file) \
   )
   ```

### ':=' vs '='

In Makefiles, there are two different assignment operators: `=` and `:=`. They have different behaviors and are used for different purposes.

1. `=` (Simple Assignment):
   - The `=` operator is used for simple assignment of variables.
   - It evaluates the right-hand side of the assignment whenever the variable is expanded.
   - If the right-hand side contains references to other variables, those references are expanded when the variable is expanded.
   - This means that changes to the referenced variables will be reflected in the assigned variable.
   - Example:
     ```make
     VAR = $(OTHER_VAR)
     OTHER_VAR = Hello
     ```
     In this case, `VAR` will be assigned the value of `OTHER_VAR` when it is expanded. So, `$(VAR)` will evaluate to `Hello`.

2. `:=` (Immediate Assignment):
   - The `:=` operator is used for immediate assignment of variables.
   - It evaluates the right-hand side of the assignment immediately when the Makefile is read, and the result is stored as a literal value.
   - If the right-hand side contains references to other variables, those references are expanded at the time of assignment.
   - This means that changes to the referenced variables will not affect the assigned variable.
   - Example:
     ```make
     VAR := $(OTHER_VAR)
     OTHER_VAR = Hello
     ```
     In this case, `VAR` will be assigned the value of `OTHER_VAR` at the time of assignment. So, `$(VAR)` will evaluate to an empty string because `OTHER_VAR` is not defined yet.

In general, it is recommended to use `:=` for most variable assignments in Makefiles, as it ensures that the assignment is immediate and avoids unexpected behavior due to changes in referenced variables. However, there may be cases where `=` is more appropriate, such as when you want the assigned variable to always reflect the current value of a referenced variable.






======================

WIP remove below

an example Makefile that uses Docker commands and resources:

Type or copy the following int the file Make

Replace 'my_image' with 'nginx' or an image of your choice.

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


run `make run`{{exec}} to run the nginx container

run `make stop`{{exec}}  and then `make clean`{{exec}}


In this Makefile:

1. We define two variables, `IMAGE_NAME` and `CONTAINER_NAME`, which will be used to specify the name of the Docker image and container, respectively.

2. We define four targets: `build`, `run`, `stop`, and `clean`. The `build` target will build the Docker image using the Dockerfile in the current directory. The `run` target will run a container from the image with the specified name. The `stop` target will stop the running container. The `clean` target will remove the container and image.

3. Each target has a set of commands that use the Docker commands to build, run, stop, or remove the Docker resources.