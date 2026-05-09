# codebuild

## buildspec

A `buildspec.yml` file is essentially a set of instructions that AWS CodeBuild follows to compile, test, and package your code. 

At its simplest, it is broken down into **phases**. Here is a "bare-bones" template you can use:

`nano buildspec.yml`{{exec}}

```yaml
version: 0.2

phases:
  install:
    commands:
      - echo "Installing dependencies..."
      # Example: - npm install
  pre_build:
    commands:
      - echo "Running tests..."
      # Example: - npm test
  build:
    commands:
      - echo "Build started on `date`"
      - echo "Compiling code..."
      # Example: - npm run build
  post_build:
    commands:
      - echo "Build completed on `date`"

artifacts:
  files:
    - '**/*' # This uploads everything in the directory to S3/CodePipeline
```{{copy}}

---

### Key Components Explained

* **`version: 0.2`**: This is the current standard version. Always use 0.2; 0.1 is deprecated and handles shell commands differently.
* **`phases`**: These represent the lifecycle of your build.
    * **install**: Best for installing runtime packages or software.
    * **pre_build**: Great for logging into Docker or running unit tests.
    * **build**: Where the actual "heavy lifting" (compiling/bundling) happens.
    * **post_build**: Used for cleanup or final notifications.
* **`artifacts`**: This tells CodeBuild **which files to keep** after the build environment is destroyed. If you don't include this, your build might "succeed," but you won't have any output files to deploy.

> **Pro Tip:** Make sure this file is named exactly `buildspec.yml` and is placed in the **root directory** of your source code. If you name it anything else or put it in a subfolder, CodeBuild won't find it unless you manually point to it in the AWS Console settings.

## Run in Ministack

Yes, **MiniStack** (the open-source local AWS emulator) does support **AWS CodeBuild**. 

In the MiniStack ecosystem, CodeBuild is one of the 45+ supported services. It allows you to create projects, start/stop builds, and manage build metadata locally—similar to how you would in a real AWS environment but without the cost or cloud latency.

### How it works in MiniStack
Since MiniStack is designed to be a drop-in replacement for LocalStack, you interact with its CodeBuild module using the standard AWS CLI or SDKs, just by pointing to the MiniStack endpoint (usually `http://localhost:4566`).

#### 1. Basic CLI Example
To create a simple project locally, you would run:
```bash
aws --endpoint-url=http://localhost:4566 codebuild create-project \
    --name MyLocalProject \
    --source type=NO_SOURCE \
    --artifacts type=NO_ARTIFACTS \
    --environment type=LINUX_CONTAINER,image=aws/codebuild/standard:5.0,computeType=BUILD_GENERAL1_SMALL \
    --service-role "arn:aws:iam::000000000000:role/service-role"
```{{exec}}

#### 2. Starting a Build
Once the project is "created" in MiniStack's memory, you can trigger it:
```bash
aws --endpoint-url=http://localhost:4566 codebuild start-build --project-name MyLocalProject
```{{exec}}

### Important Considerations
*   **Execution Environment**: While MiniStack stores the project metadata (JSON), the actual execution of your `buildspec.yml` commands may vary depending on how you've set up your local Docker environment. In some lightweight emulators, "starting a build" primarily validates the API call rather than spinning up a full-blown isolated container like the real AWS service.
*   **IAM Roles**: In MiniStack, IAM is generally "permissive" by default, meaning you don't usually need to struggle with complex policies just to get a local build to run.
*   **Infrastructure as Code**: If you use **Terraform**, you can point your AWS provider to MiniStack, and it will provision the CodeBuild resource just like it would in production.

---
**Are you looking to run actual build scripts locally, or just testing the automation logic (Terraform/SDK calls) for your CI/CD pipeline?**