



# application architecture

https://github.com/dotnet-architecture/eShopOnWeb

>>>> https://learn.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/
>>>> https://learn.microsoft.com/en-us/dotnet/architecture/?WT.mc_id=dotnet-35129-website
>>>> https://dotnet.microsoft.com/en-us/learn/microservices


# Run without dotnet

To run a .NET console program without installing .NET, you can use a self-contained deployment. This means that you package the necessary .NET runtime with your application, so it can run on any machine without requiring the installation of .NET.

 

Here are the steps to create a self-contained deployment:

 

1. Open a command prompt or terminal and navigate to the root directory of your .NET console program.

 

2. Run the following command to publish your application:

 

   ```shell

   dotnet publish -c Release -r <runtime>

   ```

 

   Replace `<runtime>` with the target runtime you want to publish for. For example, `win-x64` for Windows 64-bit, `linux-x64` for Linux 64-bit, or `osx-x64` for macOS 64-bit. You can find a list of available runtimes in the .NET documentation.

 

3. After the publish command completes, navigate to the published output directory. It should be located in the `bin/Release/netcoreapp3.1/<runtime>/publish` directory.

 

4. You can now copy the entire contents of the `publish` directory to any machine where you want to run your application.

 

5. On the target machine, navigate to the directory where you copied the published files.

 

6. Run the executable file for your application. The name of the executable will be the same as your project name.

 

Your .NET console program should now run without requiring the installation of .NET on the target machine.