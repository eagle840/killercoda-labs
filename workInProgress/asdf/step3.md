## Package management

`bundle init`{{exec}}

`cat Gemfile`{{exec}}

`bundle list`{{exec}}

`gem update bundle`{{exec}}

`gem install sidekiq`{{exec}}

add version notes

but you need a Gemfile

Bundler:

- package manager that handles gems
- Gems are std ruby libraries
- Bundler comes with Rails
- When bundler starts, gems in gemfile are installed

webpacker:

- frontend
- uses yarn (a js package manager)
- ??? why nodejs needs to be installed?

html at app/views/layouts
- .erb ruby files (erb = embeded ruby)
- a compiler, HAML process the <%=  %>

control: cli
- bin/rails generate controller welcome index

---

You can use the `bundle add` command to achieve this. Here's how you can do it:



1. Open your terminal and navigate to the root directory of your Ruby project.

2. Run the following command to install a new gem and add it to the Gemfile:

   ```

   bundle add GEM_NAME

   ```

   Replace `GEM_NAME` with the name of the gem you want to install. For example, if you want to install the `rspec` gem, you would run:

   ```

   bundle add rspec

   ```

3. Bundler will install the specified gem and automatically add it to your Gemfile with the latest version. If you want to specify a specific version of the gem, you can do so by adding the version number after the gem name. For example:

   ```

   bundle add rspec --version '3.10.0'

   ```

4. After running the `bundle add` command, you can check your Gemfile to see the newly added gem entry.



Using `bundle add` is a convenient way to quickly install a Ruby gem and have it added to your Gemfile with the specified version. 

`gem update --system`{{exec}}

`gem update bundle`{{exec}}

---

To start a new Ruby project in a folder named "koda," you will need to generate a new Ruby project structure. Here are the steps to do this:



1. Open your terminal and navigate to the directory where you want to create the new project folder "koda."



2. Run the following command to create a new Ruby project using the Bundler gem:

   

   ```

   bundle gem koda

   ```



3. This command will generate a new folder named "koda" with the basic structure for a Ruby gem project. Inside the "koda" folder, you will find the following files and directories:



   - `koda.gemspec`: This file contains information about your gem, such as its name, version, dependencies, and files to include.

   - `Gemfile`: This file specifies the gem dependencies for your project.

   - `lib/`: This directory is where you will write your Ruby code.

   - `lib/koda.rb`: This is the main Ruby file for your gem.

   - `spec/`: This directory is where you will write your tests using RSpec.

   - `Rakefile`: This file contains tasks for building, testing, and releasing your gem.

   - `README.md`: This file contains information about your gem and how to use it.



4. You can now start writing your Ruby code in the `lib/` directory and your tests in the `spec/` directory. You can also update the `koda.gemspec` file to add any additional dependencies or metadata for your gem.



5. Once you have written your code and tests, you can build your gem by running the following command:



   ```

   gem build koda.gemspec

   ```



6. This command will generate a `.gem` file in the root directory of your project. You can then install the gem locally for testing by running:



   ```

   gem install ./koda-0.1.0.gem

   ```



7. You can now require and use your gem in other Ruby projects by adding it to the Gemfile and running `bundle install`.



That's it! You have now created a new Ruby project in the "koda" folder and can start developing your Ruby gem.

---




