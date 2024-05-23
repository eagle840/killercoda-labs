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

