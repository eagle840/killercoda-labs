an example of using conditionals in a Makefile to check for the existence of a file:

```
ifeq "$(wildcard file.txt)" ""
$(error file.txt not found)
endif
```

In this example, the `ifeq` statement is used to check if the file `file.txt` exists. If the file does not exist, then the `$(error)` function is called with a message informing the user that the file is not found.

The `wildcard` function is used to check for the existence of a file. If the file exists, then the function returns the name of the file. If the file does not exist, then the function returns an empty string.