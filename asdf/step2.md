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

## other
- I've noticed alot of rails apps fail without this installd

`apt install -y libpq-dev`{{exec}}


`npm install --global yarn`{{exec}}

which we've already installed

`gem install rails -v 7.0.4`{{exec}}

`gem install foreman`{{exec}} #WIP

`rails --version`{{exec}}

`rails new blog`{{exec}}

`rails new --help`{{exec}}

`cd blog`{{exec}}

while not needed, we can use bundle dependance manager to install the gems in the Gemfile

`bundle install`{{exec}}

The bundle command in Ruby is used to manage dependencies for a Ruby project. It can be used to install, update, and remove gems, as well as to create a Gemfile.lock file, which specifies the exact versions of the gems that are needed for the project.

Here are some of the things that bundle can do:

Install gems: The `bundle install` command will install all of the gems that are listed in the Gemfile.
Update gems: The `bundle update` command will update all of the gems that are listed in the Gemfile to the latest versions.
Remove gems: The `bundle remove` command will remove a gem from the project.
Create a Gemfile.lock file: The `bundle lock` command will create a Gemfile.lock file, which specifies the exact versions of the gems that are needed for the project.


## MVC

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
