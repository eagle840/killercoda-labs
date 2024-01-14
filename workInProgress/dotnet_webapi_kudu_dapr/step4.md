# Run with DAPR
 
`wget -q https://raw.githubusercontent.com/dapr/cli/master/install/install.sh -O - | /bin/bash` {{exec}}

https://docs.dapr.io/getting-started/install-dapr-cli/


Yes, you can run your .NET ASP program along with Dapr in Docker. Dapr is a portable, event-driven runtime that simplifies the development of microservices. Here's how you can run your application with Dapr in Docker:

1. Install Dapr CLI: First, make sure you have the Dapr CLI installed on your machine. You can follow the installation instructions from the official Dapr documentation (https://docs.dapr.io/getting-started/install-dapr-cli/).

2. Update your Dockerfile: Open your Dockerfile and update it to include the Dapr sidecar. Here's an example of an updated Dockerfile:

```Dockerfile
# Use the official .NET Core SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

# Set the working directory inside the container
WORKDIR /app

# Copy the project file and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the remaining source code and build the application
COPY . ./
RUN dotnet publish -c Release -o out

# Set the entry point for the container
ENTRYPOINT ["dapr", "run", "--app-id", "your-app-id", "--app-port", "80", "--", "dotnet", "out/YourProjectName.dll"]
```

Replace "your-app-id" with a unique identifier for your application.

3. Build the Docker image: Open a terminal or command prompt, navigate to your project directory (where the Dockerfile is located), and run the following command to build the Docker image:

```
docker build -t your-image-name .
```

Replace "your-image-name" with a name of your choice for the Docker image.

4. Run the Docker container: Once the Docker image is built, you can run it using the following command:

```
docker run -d -p 80:80 -e DAPR_HTTP_PORT=3500 --name your-container-name your-image-name
```

Replace "your-container-name" with a name of your choice for the Docker container.

In this command, we're mapping port 80 of the container to port 80 of the host machine (-p 80:80) and setting the Dapr HTTP port to 3500 (-e DAPR_HTTP_PORT=3500).

5. Access your ASP.NET application: Open a web browser and navigate to http://localhost:80 to access your ASP.NET application running with Dapr inside the Docker container.

That's it! Your .NET ASP program is now running with Dapr in a Docker container.