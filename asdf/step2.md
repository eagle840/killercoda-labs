# Hello World! using ruby

ruby  versions can be found here: https://www.ruby-lang.org/en/

the main backage manager for ruby is Gems https://rubygems.org/

`ruby --version`{{exec}}

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


# debug ruby

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


# installing rails

https://guides.rubyonrails.org/v6.1/getting_started.html

## you'll need
- Ruby 
- SQLite3
- Node.js
- Yarn - we need


`npm install --global yarn`{{exec}}

which we've already installed

`gem install rails -v 6.1`{{exec}}

`rails --version`{{exec}}

`rails new blog`{{exec}}

`rails new --help`{{exec}}

`cd blog`{{exec}}

note the M(model) V(view) and Controller(control) in the app folder

also the routes.rb  file in the config folder

also the javascript folder in app


Before we start the server, we need to tell rails not to check the domain name - for this environment.

in 

`echo "Rails.application.config.hosts.clear" >> ~/blog/config/environments/development.rb`{{exec}}

`bin/rails server -b '0.0.0.0'`{{exec}} 

starts the server (-b sets the binding address)

Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_3000}}

wip this generated a rail web error, see https://guides.rubyonrails.org/configuring.html#actiondispatch-hostauthorization



fixed:  
add the  replace the guid with the correct one! 

```text
config.hosts << "d67c710d-e27b-43c4-9664-077ea62d7396-10-244-27-249-3000.spch.r.killercoda.com"
```


to the Rails.application.configure do block
in the config/environments/development.rb file


## setup home page

open /app/views/layouts.application.html.erb  'embedded ruby file'

'<%=  cmd %>'  is a single line ruby cmd

### for each page, you'll need a m & v & c


run `/bin/rails generate controller Welcome index`{{exec}}

notice a new controller of 'welcome_controller'

and a new view of /welcome/index.html.erb

and the other items in the list

review the /config/routes.rb file, with it's one method with the ccoomand we ran (welcome is the action)

add below get
'root 'welcome#index''  ? why

### add model 

run `bin/rails generate scaffold WikiPost`{{exec}}
