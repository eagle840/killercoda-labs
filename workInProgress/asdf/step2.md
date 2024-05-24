# Basic ruby 

`ruby --version`{{exec}}

## Interpreters

### Single line

Execute a single line of Ruby code using the `-e` flag:

`ruby -e 'print "Hello Ruby!\n"'`{{exec}}

### REPL (Read-Eval-Print Loop)

Install the Interactive Ruby Shell (IRB) using the following command:

`apt install irb -y`{{exec}}

`irb -v`{{exec}}

`irb`{{exec}}

`puts 'Hello Ruby'`{{exec}}

`quit`{{exec}}

### File execution

Create a Ruby script named `hello.rb` with the following content:

```
print "Hello Ruby!\n"
print "Goodbye Ruby!\n"
```{{copy}}

`nano hello.rb`{{exec}}

`ruby hello.rb`{{exec}}


## Debugging ruby

### **pry**

Pry is a powerful alternative to IRB for debugging Ruby code. Install Pry using the following command:

`gem install pry`{{exec}}

you can start a REPL session in any block of code:

```
require 'pry'
#start a REPL session
binding.pry
```


## Linting 

To lint Ruby code, you can use various tools and plugins. One popular linter for Ruby is RuboCop. Install RuboCop using the following command:

`gem install rubocop`{{exec}}



You can then run RuboCop on your Ruby files to ensure they adhere to the Ruby style guide and best practices.


