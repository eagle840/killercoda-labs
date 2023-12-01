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

