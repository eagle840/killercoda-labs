# Hello World! using ruby





# installing rails

https://guides.rubyonrails.org/v6.1/getting_started.html

## you'll need
- Ruby
- SQLite3
- Node.js
- Yarn

which we've already installed

`gem install rails -v 6.1`{{exec}}

`rails new blog`{{exec}}

`rails new --help`{{exec}}

`cd blog`{{exec}}

note the M(model) V(view) and Controller(control) in the app folder

also the routes.rb  file in the config folder

also the javascript folder in app

`bin/rails server -b '0.0.0.0'`{{exec}} 

starts the server (-b sets the binding address)

wip this generated a rail web error, see https://guides.rubyonrails.org/configuring.html#actiondispatch-hostauthorization

see config/application.rb




