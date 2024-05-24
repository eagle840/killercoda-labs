## Package management

The main package manager for Ruby is Gems, which can be found at [https://rubygems.org/](https://rubygems.org/).

- `gem`: Ruby package manager for managing Ruby gems.

- `bundle`: Dependency manager for Ruby projects that reads a `Gemfile` to install and manage gem dependencies.

### Bundler

- Bundler is a package manager that handles gems.

- Gems are standard Ruby libraries.

- When Bundler starts, gems specified in the Gemfile are installed.

`bundle init`{{exec}}

`cat Gemfile`{{exec}}

`bundle list`{{exec}}

`gem update bundle`{{exec}}

`gem install sidekiq`{{exec}}

`bundle add GEM_NAME` is used to add a new gem dependency to your project, `bundle install GEM_NAME` is used to install the specified gem and its dependencies, `bundle install` is used to install all gems specified in your `Gemfile`, and `gem install GEM_NAME` is used to install a gem globally on your system.

Bundler will install the specified gem and automatically add it to your Gemfile with the latest version. If you want to specify a specific version of the gem, you can do so by adding the version number after the gem name. For example:



`bundle add rspec --version '3.10.0'`





Using `bundle add` is a convenient way to quickly install a Ruby gem and have it added to your Gemfile with the specified version. 

`gem update --system`{{exec}}

`gem update bundle`{{exec}}



1. `gem update --system`: This command is used to update the RubyGems software itself to the latest version. When you run `gem update --system`, RubyGems will check for updates to the RubyGems software and install the latest version if available. This command is used to keep the RubyGems package manager up to date with the latest features and bug fixes.



2. `gem update bundle`: This command is used to update a specific gem, in this case, the Bundler gem. When you run `gem update bundle`, RubyGems will check for updates to the Bundler gem and install the latest version if available. This command is used to update the Bundler gem to the latest version, ensuring that you have the most recent features and bug fixes for the Bundler dependency manager.
---


## Starting a new project

The `bundle gem PROJECT_NAME` command is used to generate a new Ruby gem project template using Bundler. When you run this command, Bundler will create a new directory with the specified `PROJECT_NAME` and set up the basic structure for a Ruby gem project inside that directory.



The `bundle gem` command will generate the following files and directories in the new project directory:


1. `PROJECT_NAME.gemspec`: This file contains information about the gem, such as its name, version, dependencies, and other metadata.

2. `lib/PROJECT_NAME.rb`: This is the main Ruby file for the gem, where you can define the functionality of your gem.

3. `lib/PROJECT_NAME/`: This directory can be used to organize your gem's code into multiple files or subdirectories.

4. `bin/`: This directory can contain executable scripts that are included with your gem.

5. `test/`: This directory can contain test files for your gem using a testing framework like Minitest or RSpec.

6. `README.md`: This file can contain information about your gem, including usage instructions and documentation.

To start a new Ruby project in a folder named "koda," you will need to generate a new Ruby project structure. Here are the steps to do this:



Run the following command - and can just hit enter until it's commplete.

`bundle gem myproject`{{exec}}




