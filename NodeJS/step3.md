# Step 3 YARN Deep Dive

Yarn was created by Facebook in collaboration with Exponent, Google, and Tilde in 2016 as a response to some of the limitations and performance issues with npm. Yarn was designed to address the shortcomings of npm, such as slow package installations, lack of determinism in dependency resolution, and security vulnerabilities. Yarn introduced features like a lockfile for deterministic installations, offline mode, and parallel package downloads to improve the overall performance and reliability of package management in Node.js projects. Since its release, Yarn has gained popularity in the Node.js community and is now widely used as an alternative to npm for managing dependencies.

Here is a list of major versions of Yarn and the features they added, along with the year they were released:

1. Yarn 1 (2016):
   - Introduced lockfile for deterministic installations
   - Added offline mode for package installations
   - Improved performance with parallel package downloads

2. Yarn 2 (Berry) (2020):
   - Rewritten in TypeScript for improved maintainability
   - Introduced Plug'n'Play for faster and more efficient package resolutions
   - Removed the need for a lockfile in favor of a single source of truth

## Commands

The commands in Yarn are similar to npm but have some differences in syntax and behavior. Here is how the Yarn commands differ from npm:

1. `yarn init`: Initializes a new Node.js project and creates a `package.json` file, similar to `npm init`. It prompts you to enter project details such as name, version, description, entry point, and more.

2. `yarn install`: Installs dependencies listed in the `dependencies` and `devDependencies` sections of the `package.json` file, similar to `npm install`. Yarn fetches packages from the npm registry or Yarn's own cache and installs them.

3. `yarn add <package-name>`: Installs a specific package and adds it to the `dependencies` section of the `package.json` file, similar to `npm install <package-name>`. Yarn automatically saves the package as a dependency.

4. `yarn add <package-name> --dev`: Installs a package as a development dependency and adds it to the `devDependencies` section of the `package.json` file, similar to `npm install --save-dev <package-name>`.

5. `yarn upgrade`: Upgrades packages to their latest versions based on the version ranges specified in the `package.json` file, similar to `npm update`. Yarn checks for newer versions of dependencies and updates them accordingly.

6. `yarn remove <package-name>`: Uninstalls a package from the project and removes it from the `dependencies` or `devDependencies` section of the `package.json` file, similar to `npm uninstall <package-name>`.

Overall, Yarn commands are designed to be faster and more reliable than npm, with features like parallel package installations, deterministic dependency resolution, and offline mode. The syntax for Yarn commands is slightly different from npm, but the functionality is similar.

## Additional Commands

In addition to the common commands for managing dependencies and initializing projects, Yarn provides several other useful commands for various tasks in Node.js projects. Some of the important Yarn commands include:

1. `yarn start`: Runs the script defined in the `start` field of the `scripts` section in the `package.json` file. This command is commonly used to start the application or server.

2. `yarn test`: Runs the test scripts defined in the `scripts` section of the `package.json` file. This command is used to execute test suites and ensure the correctness of the application.

3. `yarn build`: Runs the build script defined in the `scripts` section of the `package.json` file. This command is typically used to compile, transpile, or bundle the project for production deployment.

4. `yarn lint`: Runs linting tools such as ESLint or Prettier to check the code for syntax errors, style violations, and best practices.

5. `yarn run <script-name>`: Executes a custom script defined in the `scripts` section of the `package.json` file. This command allows you to run any custom script specified in the `package.json`.

6. `yarn cache clean`: Clears the Yarn cache, which can help resolve issues related to cached packages or corrupted cache data.

7. `yarn list`: Lists all installed packages and their versions in the project.

8. `yarn why <package-name>`: Displays information about why a specific package is installed in the project, including which dependencies require it.

These commands, along with the common dependency management commands, provide developers with a comprehensive set of tools for managing Node.js projects efficiently using Yarn