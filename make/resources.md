WIP
- need to add
- .phony
- simple conditionals


reducing output
```
ifndef VERBOSE
.SILENT:
endif
```


chatGPT

The best way to log actions in a Makefile is to use the built-in logging capabilities provided by the Make tool itself. Make provides several built-in variables and functions that can be used to log actions and messages during the build process.

Here are a few approaches you can take:

1. Use the `$(info ...)` function: This function allows you to print messages to the console during the execution of the Makefile. You can use it to log actions or display information about the build process. For example:

   ```make
   $(info Building target: $(TARGET))
   ```

2. Use the `@echo ...` command: The `@` symbol before the `echo` command suppresses the printing of the command itself, only printing the message. This can be useful for logging actions without cluttering the console with unnecessary output. For example:

   ```make
   build:
       @echo "Building target: $(TARGET)"
       # Build commands...
   ```

3. Use the `$(warning ...)` function: This function allows you to print warning messages during the build process. It can be useful for logging potential issues or important information. For example:

   ```make
   $(warning This target is deprecated: $(TARGET))
   ```

4. Redirect output to a log file: You can redirect the output of the Makefile to a log file using the `>` operator. This allows you to capture all the log messages in a file for later analysis. For example:

   ```shell
   make > build.log
   ```

   This will redirect all output, including log messages, to the `build.log` file.

Remember to use these logging techniques judiciously and provide meaningful information to aid in troubleshooting and understanding the build process.

###################

Make also provides the ability to run prerequisites in parallel using parallel execution. This can be achieved by using the `.ONESHELL` special target and the `&` operator to run commands in the background. Here's an example:

```make
.ONESHELL:
output: input1.txt input2.txt
    @echo "Building output file..."
    @cp input1.txt output &
    @cp input2.txt output &
    @wait
    @echo "Output file built."
```

In this modified example, the `&` operator is used to run the `cp` commands in the background. The `wait` command is then used to wait for all background processes to finish before proceeding. This allows the prerequisites to be built in parallel.

It's important to note that parallel execution can introduce complexities and potential issues, especially if the prerequisites have dependencies on each other or if they modify shared resources. Therefore, it should be used with caution and only when necessary.