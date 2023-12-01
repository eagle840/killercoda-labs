# Monitor Java

The test program.

`nano HelloMultple.java`{{exec}}

```
import java.time.LocalTime;

public class HelloMultple {

    public static void main(String[] args) throws InterruptedException {

        LocalTime endTime = LocalTime.now().plusMinutes(2);

 

        while (LocalTime.now().isBefore(endTime)) {

            System.out.println(LocalTime.now());

            Thread.sleep(1000); // Sleep for 1 second

        }

    }

}
```


`javac HelloMultple.java`{{exec}}


`java HelloMultple`{{exec}}



## List the JVM's

The `jps` command is a utility provided by the Java Development Kit (JDK) that lists the Java Virtual Machines (JVMs) running on a machine. It stands for "Java Virtual Machine Process Status Tool".

 

When you run the `jps` command in a terminal or command prompt, it will display a list of all the Java processes (JVMs) running on your system, along with their process IDs (PIDs) and the names of the main classes or JAR files being executed.

 

The `jps` command is useful for identifying and monitoring Java processes running on your machine. It can be used to check if a Java application or server is running, find the process ID of a specific Java process, or troubleshoot issues related to Java processes.

 Open a new termina;

`jps -v`{{exec}}

There are several other commands available in the Java Development Kit (JDK) that are useful for managing and monitoring Java processes. Here are a few commonly used ones:

## Other tools
 

1. `jstat`: The `jstat` command is used to monitor JVM statistics such as garbage collection, memory usage, and class loading. It provides real-time information about the behavior and performance of a running Java application.

 

2. `jmap`: The `jmap` command is used to generate a memory map of a Java process. It can be used to analyze the memory usage of a Java application, including heap and non-heap memory, object counts, and memory allocation details.

 

3. `jstack`: The `jstack` command is used to print the stack traces of Java threads in a Java process. It is helpful for diagnosing thread-related issues such as deadlocks or high CPU usage.

 

4. `jcmd`: The `jcmd` command is a versatile command-line tool that can perform various operations on a Java process, such as taking thread dumps, heap dumps, or system properties, as well as executing diagnostic commands provided by the JVM.

 

5. `jvisualvm`: The `jvisualvm` command launches a graphical user interface (GUI) tool for monitoring and profiling Java applications. It provides a comprehensive set of tools for analyzing thread behavior, memory usage, CPU profiling, and more. ISSUES INStALLING

 

These are just a few examples of the many commands available in the JDK for managing and monitoring Java processes. Each command serves a specific purpose and can be used to gather valuable information about the runtime behavior and performance of Java applications.

 

## jstat

 

To use the `jstat` command, follow these steps:

 

1. Open a terminal or command prompt.

 

2. Identify the process ID (PID) of the Java process you want to monitor. You can use the `jps` command to list all the Java processes running on your system and their corresponding PIDs. For example:

        `jps`{{exec}}

  

 

3. Once you have the PID of the Java process, run the `jstat` command followed by the PID and the desired options. The basic syntax is as follows:

  

        `jstat [options] <PID> [interval] [count]`



 

   - `<PID>`: Replace this with the process ID of the Java process you want to monitor.

   - `[interval]`: Optional. Specifies the interval (in milliseconds) between each sample. If not specified, the default interval is 1000ms (1 second).

   - `[count]`: Optional. Specifies the number of samples to be taken. If not specified, the default count is infinite.

 

4. Choose the desired options for the `jstat` command based on the statistics you want to monitor. Here are some commonly used options:

 

   - `-gc`: Provides garbage collection statistics, including heap utilization, garbage collection time, and more.

   - `-class`: Displays class loader statistics, such as the number of loaded classes, unloaded classes, and class loading time.

   - `-compiler`: Shows Just-In-Time (JIT) compiler statistics, including the number of compiled methods and compilation time.

   - `-gcutil`: Provides a summary of garbage collection statistics, including heap utilization, garbage collection time, and percentage of time spent in garbage collection.

 

   You can find more options and details in the official documentation for `jstat`.

 

5. Run the `jstat` command with the desired options. For example, to monitor garbage collection statistics for a Java process with PID 12345 every 5 seconds for a total of 10 samples, you can use the following command:



        `jstat -gc 12345 5000 10``

 

   The output will display the requested statistics for each sample taken.

 

 

 

`jstat --help`{{exec}}

`jstat -options`{{exec}}

 

 

RUN THE 2min program

 

`jps`{{exec}}

`jstat -gc <pid>`

 



