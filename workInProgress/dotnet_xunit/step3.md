To create a simple "Hello World" example of testing with xUnit in a Katacoda lab, you can follow these steps:

1. Create a new xUnit test project:
```bash
dotnet new xunit -n HelloWorldTest
cd HelloWorldTest
```{{exec}}

2. Open the project in a code editor:
```bash
code .
```

3. Create a new test class with a "Hello World" test method:
In the `UnitTest1.cs` file, replace the existing test method with the following code:
```csharp
using System;
using Xunit;

namespace HelloWorldTest
{
    public class UnitTest1
    {
        [Fact]
        public void TestHelloWorld()
        {
            // Arrange
            string expected = "Hello, World!";
            
            // Act
            string actual = "Hello, World!";
            
            // Assert
            Assert.Equal(expected, actual);
        }
    }
}
```{{copy}}

4. Run the xUnit tests:
```bash
dotnet test
```{{exec}}

5. Verify that the test passes:
You should see an output indicating that the test passed successfully.

This simple example demonstrates a basic "Hello World" test using xUnit in a Katacoda lab. You can further explore xUnit's features, such as parameterized tests, test fixtures, and assertions, to enhance your testing skills and create more comprehensive test suites for your dotnet projects.