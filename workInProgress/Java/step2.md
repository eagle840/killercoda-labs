


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

WIP move this to step 3 (and up those past)

also gradle will be step 4?

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

`cd ~`{{exec}}

`mkdir helloworld`{{exec}}

`cd helloworld`{{exec}}

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

`touch pom.xml`{{exec}}

## pom file

```
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.helloworld</groupId>
  <artifactId>helloworld</artifactId>
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

`tree`{{exec}}

why is the above showing no new files?


This command will clean the project by deleting the `target` directory and any other generated files, preparing it for a fresh build.


## now compile

`mvn compile`{{exec}}

`tree`{{exec}}

why is the above showing no new files?

cd target

cd classes

ls

java program