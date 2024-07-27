# Java

## Distributions

The main distributions of Java are:

1. Oracle JDK (Java Development Kit): This is the official distribution provided by Oracle. It includes the Java Runtime Environment (JRE) and the tools necessary for developing, debugging, and monitoring Java applications.

2. OpenJDK: This is an open-source implementation of the Java Development Kit. It is maintained by the OpenJDK community and is the basis for many other Java distributions.

3. AdoptOpenJDK: This is a community-driven distribution of OpenJDK. 

4. Amazon Corretto: This is a no-cost, multiplatform, production-ready distribution of OpenJDK provided by Amazon. 

5. Azul Zulu: This is a certified, freely available distribution of OpenJDK provided by Azul Systems.

6. IBM SDK for Java: This is a distribution of OpenJDK provided by IBM. 

## Editions

Java has different editions and profiles that cater to specific use cases. Here are some of the different versions of Java:

1. Java SE (Standard Edition): This is the most common and widely used edition of Java. It provides the core functionality and libraries for developing general-purpose Java applications.

2. Java EE (Enterprise Edition): This edition is designed for developing enterprise-level applications. It includes additional APIs and features for building distributed, scalable, and secure applications.

3. Java ME (Micro Edition): This edition is targeted towards developing applications for resource-constrained devices like mobile phones, embedded systems, and IoT devices.

4. Java FX (JavaFX): JavaFX is a platform for building rich desktop and web applications. It provides a set of APIs and tools for creating visually appealing user interfaces and multimedia applications.

5. Java Card: Java Card is a subset of Java ME specifically designed for smart cards and other small-memory devices. It enables the development of secure applications for authentication, payment, and other card-based services.


## Releases/Versions

1. Java 1.0: Initial release in 1996.
2. Java 1.2 (Java 2): Released in 1998, introduced the Java 2 platform.
3. Java 5 (Java 1.5): Released in 2004, introduced generics and annotations.
4. Java 8: Released in 2014, introduced lambda expressions and the Stream API.
5. Java 11: Released in 2018, a long-term support (LTS) version with various enhancements.
6. Java 17: Released in 2021, the latest LTS version with new features and improvements.

## JRE vs JDK 

Runtime: The Java Runtime Environment (JRE) is needed to run Java applications. It includes the Java Virtual Machine (JVM) and core libraries.

SDK: The Software Development Kit (SDK) is used for Java development, also known as the Java Development Kit (JDK) . It includes the JRE and tools for compiling, debugging, and packaging Java applications.


## Install

The command to install JRE (Java Runtime Environment) on Ubuntu is:


`sudo apt-get install default-jre`{{copy}}

To install JDK (Java Development Kit) on Ubuntu, you can use the following command:

RUN THIS: `sudo apt-get install default-jdk`{{exec}}

A headless installation refers to installing a software package without any graphical user interface (GUI) components.

run: `sudo apt-get install openjdk-11-jdk-headless`{{exec}}



--- CHECK BELOW

`java -version`{{exec}}



`ls -lash /usr/lib/jvm/`{{exec}}

### set java environment

locate /usr/lib/jvm/java-1.x.x-openjdk

 `vim /etc/profile`{{exec}}

Prepend sudo if logged in as not-privileged user, ie. sudo vim

Press 'i' to get in insert mode
add:

export JAVA_HOME="path that you found"

export PATH=$JAVA_HOME/bin:$PATH
Reboot your system, and voila

`export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64/"`{{copy}}

`export PATH=$JAVA_HOME/bin:$PATH`{{exec}}

`exec bash`{{exec}}

`echo $PATH`{{exec}}




## Maven

Maven is a build automation tool used primarily for Java projects. It provides a way to manage project dependencies, build and package projects, and manage project documentation. Maven uses a declarative XML-based configuration file called pom.xml (Project Object Model) to define the project structure, dependencies, and build process. It also supports various plugins that can be used to extend its functionality. Maven simplifies the build process by providing a standard way to manage dependencies and build projects, making it easier to share and collaborate on Java projects.

`apt install -y maven`{{exec}}

`mvn --version`{{exec}}

 The "Hello World" example in Maven involves creating a simple Java project and building it using Maven. Here are the steps to create a basic "Hello World" Maven project:

1. Open a terminal or command prompt and navigate to the directory where you want to create the project.

2. Run the following command to create a new Maven project:
   ```
   mvn archetype:generate -DgroupId=com.example -DartifactId=helloworld -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
   ```

   This command uses the Maven archetype plugin to generate a new project based on the "maven-archetype-quickstart" archetype. It sets the group ID to "com.example" and the artifact ID to "helloworld". The "interactiveMode=false" flag skips the interactive mode and uses default values.

3. Once the project is created, navigate into the project directory:
   ```
   cd helloworld
   ```

4. Open the project in your preferred IDE or text editor.

5. In the `src/main/java/com/example/App.java` file, replace the existing code with the following "Hello World" code:
   ```java
   package com.example;

   public class App {
       public static void main(String[] args) {
           System.out.println("Hello, World!");
       }
   }
   ```

6. Save the file.

7. Open a terminal or command prompt and navigate to the project directory.

8. Run the following command to build the project:
   ```
   mvn clean package
   ```

   This command uses Maven to compile the Java code, run tests (if any), and package the project into a JAR file.

9. After the build is successful, you can run the application using the following command:
   ```
   java -cp target/helloworld-1.0-SNAPSHOT.jar com.example.App
   ```

   This command runs the compiled Java code and prints "Hello, World!" to the console.

That's it! You have created a basic "Hello World" Maven project and built it using Maven.

```
Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_80}}
Link for traffic into host 2 on port 4444
{{TRAFFIC_HOST2_4444}}
Link for traffic into host X on port Y
{{TRAFFIC_HOSTX_Y}}
```

---

## Maven v2

In a typical Java project using Maven, the file structure would look something like this:

Many IDE will not show the main/java/com/example structure

```
hello-world
├── src
│   ├── main
│   │   ├── java
│   │   │   └── com
│   │   │       └── example
│   │   │           └── HelloWorld.java
│   └── test
│       └── java
│           └── com
│               └── example
│                   └── HelloWorldTest.java
├── pom.xml
└── README.md
```

Here's a breakdown of the file structure:

1. `src/main/java`: This is where your main Java source code resides. In this case, the `HelloWorld.java` file contains the 'hello world' program.

2. `src/test/java`: This is where your test source code resides. The `HelloWorldTest.java` file contains test cases for the `HelloWorld` class.

3. `pom.xml`: This is the Maven Project Object Model file that defines the project configuration, dependencies, and build settings.

4. `README.md`: This file typically contains information about the project, how to build and run it, and any other relevant details.

This is a basic structure for a simple 'hello world' program written in Java using Maven. You can customize this structure based on the requirements of your project.

## create the HelloWorld.java

In the director as shown above

`mkdir -p src/test/java/com/example && touch src/test/java/com/example/HelloWorldTest.java`{{exec}}

```
class Test
{
    public static void main(String []args)
    {
        System.out.println("My First Java Program.");
    }
};
```{{copy}}

## pom file

```
<?xml version="1.0" encoding="UTF-8" ?>
<project xmls="http://maven.apache.org/POM/4.0.0">
  <modelVersion>4.0.0</modelVersion>
 
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-app</artifactId>
  <version>1</version>
  <packaging>jar</packaging>
</project>
```

I think the artifactId might have to equal the project title?

### run clean


When you have Maven installed, you would typically run the `mvn clean` command from the root directory of your Maven project. This is the directory that contains the `pom.xml` file, which is the Maven Project Object Model file that defines the project configuration.

So, if your project is structured as mentioned earlier with the `pom.xml` file in the root directory, you would navigate to that directory in your terminal and run the `mvn clean` command. Here's an example:


`cd /path/to/your/hello-world-project`

`mvn clean`{{exec}}


This command will clean the project by deleting the `target` directory and any other generated files, preparing it for a fresh build.


## now compile

`mvn compile`{{exec}}

cd target

cd classes

ls

java program