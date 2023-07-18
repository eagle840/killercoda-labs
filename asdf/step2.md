# Basic ruby 

ruby  versions can be found here: https://www.ruby-lang.org/en/

the main backage manager for ruby is Gems https://rubygems.org/

`ruby --version`{{exec}}

## Interpreters

### single line

`ruby -e 'print "Hello Ruby!\n"'`{{exec}}

### REPL

`apt install irb`{{exec}}

`irb -v`{{exec}}

`irb`{{exec}}

`puts 'Hello Ruby'`{{exec}}

`quit`{{exec}}

### file execution

```
print "Hello Ruby!\n"
print "Goodbye Ruby!\n"
```

`nano hello.rb`{{exec}}

`ruby hello.rb`{{exec}}


## debugging ruby

### pry

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

## linting 

>> how to lint ruby <<

## Package management

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


