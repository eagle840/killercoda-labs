# Model-View-Controller (MVC) Architecture


WIP review PS:the big picture

- Explanation of MVC pattern and its importance in Rails
- Creating a simple model, view, and controller
- Defining database migrations and running them
- Performing CRUD operations using Rails console


control: router+controler => actionPack model



Sure! Here are some example commands to illustrate the MVC architecture in Ruby on Rails:

1. Generate a new Rails application:

`cd ~`{{exec}}   

`rails new myapp --css tailwind`{{exec}}

The -css addes the layout? tailwind


2. Generate a new model, view, and controller:

`cd myapp`{{exec}}

Models are controlled with the ORM ActiveRecord (add link)

WIP ignore for now `rails generate model User name:string email:string`{{exec}}

WIP ignore for now `rails generate controller Users index show new create edit update destroy`{{exec}}



3. Define a database migration and run it:

WIP ignore for now `rails generate migration AddAgeToUsers age:integer`{{exec}}

WIP ignore for now `rails db:migrate`{{exec}}


# do this

`rails generate scaffold Person name email`

    8  # run server and see error, note that we shold run the migration
    9  # click on the 'run pendings migration' on web page to resolve


  # goto /people  




WIP try this:

add `config.hosts.clear` to the  **config/environments/development.rb** file, in the 'do' section

Start the Rails server

`rails server -b 0.0.0.0`{{exec}}

On killacode: {{TRAFFIC_HOST1_3000}}


check the routing files, note the users/index

check the ./app/views/index.html.erb

add `<p>Hello Rails</p>`



4. Perform CRUD operations using Rails console:

`rails console`{{exec}}



```
# Create a new user
user = User.new(name: "John Doe", email: "john@example.com")
user.save
```

```
# Read user data
User.all
User.find(1)

# Update user data
user = User.find(1)
user.name = "Jane Doe"
user.save

# Delete a user
user = User.find(1)
user.destroy
```

`quit`{{exec}}

These commands demonstrate the basic usage of models, views, and controllers in Rails. You can modify the model attributes, controller actions, and view templates to suit your specific lab requirements.

---

add `config.hosts.clear` to the  **config/environments/development.rb** file, in the 'do' section

Start the Rails server

`rails server -b 0.0.0.0`{{exec}}


