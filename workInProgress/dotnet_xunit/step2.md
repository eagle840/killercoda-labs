WIP I get error on this, try step 3

To set up XUnit testing with a simple console .NET project called myApp, you can follow these steps:

1. Create a new console .NET project called myApp:
```bash
dotnet new console -n myApp
```{{exec}}

2. Navigate to the project directory:
```bash
cd myApp
```{{exec}}

3. Add a reference to the XUnit NuGet package:
```bash
dotnet add package xunit
```{{exec}}

4. Add a reference to the XUnit test runner NuGet package:
```bash
dotnet add package xunit.runner.console
```{{exec}}

5. Create a new folder named "Tests" in the project directory to store your test files:
```bash
mkdir Tests
```{{exec}}

6. Create a new XUnit test class in the "Tests" folder. For example, create a file named "MyAppTests.cs" with the following content:
```csharp
using Xunit;

public class MyAppTests
{
    [Fact]
    public void Test1()
    {
        // Arrange
        int a = 1;
        int b = 2;

        // Act
        int result = a + b;

        // Assert
        Assert.Equal(3, result);
    }
}
```{{copy}}

7. Build the project to ensure everything is set up correctly:
```bash
dotnet build
```{{exec}}

8. Run the XUnit test using the test runner:
```bash
dotnet test
```{{exec}}

If everything is set up correctly, you should see the XUnit test runner executing your test and providing the test results.

That's it! You have now set up XUnit testing with a simple console .NET project called myApp. You can continue adding more tests and test classes as needed to test your application logic.


---

# Sample from xunit.net

https://xunit.net/docs/getting-started/netcore/cmdline

```bash
mkdir MyFirstUnitTests
cd MyFirstUnitTests
dotnet new xunit
```{{exec}}


review csproj

`dotnet test`{{exec}}



```
[Theory]
[InlineData(3)]
[InlineData(5)]
[InlineData(6)]
public void MyFirstTheory(int value)
{
    Assert.True(IsOdd(value));
}

bool IsOdd(int value)
{
    return value % 2 == 1;
}

```

`dotnet test`{{exec}}