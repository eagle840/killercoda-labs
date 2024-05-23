# Basic ruby 



The main backage manager for ruby is Gems https://rubygems.org/

`ruby --version`{{exec}}

## Interpreters

### Single line

`ruby -e 'print "Hello Ruby!\n"'`{{exec}}

### REPL

`apt install irb -y`{{exec}}

`irb -v`{{exec}}

`irb`{{exec}}

`puts 'Hello Ruby'`{{exec}}

`quit`{{exec}}

### File execution

Copy the following into hello.rb

```
print "Hello Ruby!\n"
print "Goodbye Ruby!\n"
```{{copy}}

`nano hello.rb`{{exec}}

`ruby hello.rb`{{exec}}


## Debugging ruby

### **pry**

irb on steriods

`gem install pry`{{exec}}

you can start a REPL session in any block of code:

```
require 'pry'
#start a REPL session
binding.pry
```




### byebug

https://rubygems.org/gems/byebug

## Linting 

>> how to lint ruby <<

## Package management

`bundle init`{{exec}}

`cat Gemfile`{{exec}}

`bundle list`{{exec}}

`gem update bundle`{{exec}}

`gem install sidekiq`{{exec}}

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


