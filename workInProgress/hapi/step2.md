`mkdir myproject`{{exec}}

`cd myproject`{{exec}}

`npm init`{{exec}}

`npm install @hapi/hapi`{{exec}}

```
'use strict';

const Hapi = require('@hapi/hapi');

const init = async () => {

    const server = Hapi.server({
        port: 3000,
        host: 'localhost'
    });

    server.route({
        method: 'GET',
        path: '/',
        handler: (request, h) => {

            return 'Hello World!';
        }
    });

    await server.start();
    console.log('Server running on %s', server.info.uri);
};

process.on('unhandledRejection', (err) => {

    console.log(err);
    process.exit(1);
});

init();
```

---

When you run the command `yarn`, it is typically used in a JavaScript project to manage dependencies and run scripts defined in the `package.json` file.

Here are the main functions of the `yarn` command:

1. **Install Dependencies**: If there is a `package.json` file in the current directory, `yarn` will read it and install all the dependencies listed in the file. It will download the required packages from the npm registry and store them in the `node_modules` directory.

2. **Update Dependencies**: If there is already a `node_modules` directory in the project, `yarn` will check for any updates to the dependencies listed in the `package.json` file. It will download and install the updated packages.

3. **Run Scripts**: The `package.json` file can define custom scripts that can be executed using `yarn`. For example, you can define a script called `start` that runs your application. You can run this script using `yarn start`.

4. **Manage Packages**: `yarn` provides commands to add, remove, and upgrade packages. For example, you can use `yarn add <package-name>` to add a new package to your project, `yarn remove <package-name>` to remove a package, and `yarn upgrade <package-name>` to upgrade a specific package.

Overall, `yarn` is a powerful package manager that simplifies dependency management and provides a consistent and reliable way to manage JavaScript projects.

`cat package.json`{{exec}}

`yarn`{{exec}}

When you run the command `yarn build`, it typically executes a build script defined in the `package.json` file of a JavaScript project. The specific behavior of the `yarn build` command can vary depending on how it is configured in the project.

Here are some common actions that may occur when running `yarn build`:

1. **Transpiling and Bundling**: The build script may use tools like Babel or TypeScript to transpile the source code into a compatible format for the target environment. It can also bundle the code and its dependencies into a single file or a set of optimized files.

2. **Optimizations**: The build script may perform optimizations on the code, such as minification, tree shaking, or dead code elimination. These optimizations aim to reduce the size of the output files and improve the performance of the application.

3. **Asset Management**: If the project includes static assets like images, fonts, or CSS files, the build script may handle their processing and inclusion in the final build. This can involve tasks like copying, compressing, or transforming these assets as needed.

4. **Environment-specific Configurations**: The build script may apply environment-specific configurations or variables. For example, it can set different API endpoints or feature flags based on whether the build is for development, staging, or production environments.

5. **Output Generation**: The build script typically generates the final build artifacts, which can include compiled JavaScript files, CSS stylesheets, HTML files, and any other necessary files for the application to run.

The exact behavior of `yarn build` depends on how it is configured in the project's `package.json` file and the specific build tools and scripts used in the project. It is common for projects to have custom build scripts tailored to their specific requirements.

`yarn build`{{exec}}


# Run the program

`yarn runner:start`{{exec}}

{{TRAFFIC_HOST1_3009}}
