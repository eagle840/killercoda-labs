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

## Install prereqs for this lab

`sudo apt-get install -y tree`{{copy}}


## Install Java

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

# Setup java program




`nano HelloWorld.java`{{exec}}

Here's a simple "Hello, World!" program in Java:

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

To run this program, you can save it in a file named `HelloWorld.java`, then compile and execute it using the following commands:

`javac HelloWorld.java`{{exec}}


`java HelloWorld`{{exec}}


You should see the output `Hello, World!` printed to the console.

To see a verbose outpur

`javac -verbose HelloWorld.java`{{exec}}