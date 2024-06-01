# Model-View-Controller (MVC) Architecture

- Explanation of MVC pattern and its importance in Rails
- Creating a simple model, view, and controller
- Defining database migrations and running them
- Performing CRUD operations using Rails console


Sure! Here are some example commands to illustrate the MVC architecture in Ruby on Rails:

1. Generate a new Rails application:

`cd ~`{{exec}}

`rails new myapp`{{exec}}


2. Generate a new model, view, and controller:

`cd myapp`{{exec}}

`rails generate model User name:string email:string`{{exec}}

`rails generate controller Users index show new create edit update destroy`{{exec}}



3. Define a database migration and run it:

`rails generate migration AddAgeToUsers age:integer`{{exec}}

`rails db:migrate`{{exec}}

WIP try this:

add `config.hosts.clear` to the  **config/environments/development.rb** file, in the 'do' section

Start the Rails server

`rails server -b 0.0.0.0`{{exec}}



4. Perform CRUD operations using Rails console:

`rails console`{{exec}}



```
# Create a new user
user = User.new(name: "John Doe", email: "john@example.com")
user.save

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
```{{exec}}

`quit`{{exec}}

These commands demonstrate the basic usage of models, views, and controllers in Rails. You can modify the model attributes, controller actions, and view templates to suit your specific lab requirements.

---

add `config.hosts.clear` to the  **config/environments/development.rb** file, in the 'do' section

Start the Rails server

`rails server -b 0.0.0.0`{{exec}}


