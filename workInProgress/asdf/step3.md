# iMOVE TO  rails labs

https://guides.rubyonrails.org/v6.1/getting_started.html

## you'll need
- Ruby 
- SQLite3
- Node.js
- Yarn - we need

## other
- I've noticed alot of rails apps fail without this installd

`apt install -y libpq-dev`{{copy}} ## WIP remove 


`npm install --global yarn`{{exec}}

which we've already installed

`gem update --system`{{exec}}

`gem update bundle`{{exec}}

`gem install rails -v 7.0.4`{{exec}}

`gem install foreman`{{exec}} 

`rails --version`{{exec}}

`rails new blog`{{exec}}

`rails new --help`{{exec}}

Details on the command line https://guides.rubyonrails.org/command_line.html

`cd blog`{{exec}}

while not needed, we can use bundle dependance manager to install the gems in the Gemfile

`bundle install`{{exec}}

The bundle command in Ruby is used to manage dependencies for a Ruby project. It can be used to install, update, and remove gems, as well as to create a Gemfile.lock file, which specifies the exact versions of the gems that are needed for the project.

Here are some of the things that bundle can do:

Install gems: The `bundle install` command will install all of the gems that are listed in the Gemfile.
Update gems: The `bundle update` command will update all of the gems that are listed in the Gemfile to the latest versions.
Remove gems: The `bundle remove` command will remove a gem from the project.
Create a Gemfile.lock file: The `bundle lock` command will create a Gemfile.lock file, which specifies the exact versions of the gems that are needed for the project.

## Starting rails

Before we start the server, we need to tell rails not to check the domain name - for this environment.

in 

`echo "Rails.application.config.hosts.clear" >> ~/blog/config/environments/development.rb`{{exec}}

`bin/rails server -b '0.0.0.0'`{{exec}} 

You can also set the host name to listen on with 
```text
config.hosts << "railsapp.example.com"

```

starts the server (-b sets the binding address)

Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_3000}}

see https://guides.rubyonrails.org/configuring.html#actiondispatch-hostauthorization


Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_3000}}


## MVC

note the M(model) V(view) and Controller(control) in the app folder

also the routes.rb  file in the config folder

also the javascript folder in app


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



## Debug rails

if you look at the Gemfile for the rails app you've installed,

you'll notice the following gems:#
- byebug
- web-console

in one of the controller methods, add 'console' and the web gui will give a console

### Console access 

To start the Ruby on Rails console (irb), also known as the Rails console or Rails console mode, follow these steps:

1. Open your terminal or command prompt.
2. Navigate to the root directory of your Ruby on Rails project using the 'cd' command. For example, if your project is located in the 'myapp' folder, run: `cd myapp`
3. Once you're in your project's root directory, run the following command to start the Rails console: `rails console` or `rails c`
4. After executing the command, you should see a prompt indicating that the console is running, which looks like: `Loading development environment (Rails 6.x.x)`. This means you have successfully entered the Rails console.

If you create a default blog app in Rails, the Rails console provides access to various components of your application, including models, controllers, and database records. Here are some examples of what you can do in the Rails console:

 

1. Create, read, update, and delete records in the database:

   - Create a new blog post: `Post.create(title: "My First Post", content: "Hello, world!")`

   - Retrieve all blog posts: `Post.all`

   - Update a blog post: `post = Post.find(1); post.title = "Updated Title"; post.save`

   - Delete a blog post: `Post.find(1).destroy`

 

2. Query the database using ActiveRecord methods:

   - Find a specific blog post: `Post.find(1)`

   - Find blog posts with a specific condition: `Post.where(category: "Technology")`

   - Order blog posts by a specific attribute: `Post.order(created_at: :desc)`

   - Perform complex queries using ActiveRecord query methods.

 

3. Interact with models and their associations:

   - Access associations of a model: `post.comments` (assuming a `Post` model has a `has_many :comments` association)

   - Create associated records: `post.comments

   In the Rails console, you can use ActiveRecord methods to interact with your application's database. Here are some common ways to find information about the database:

### Database queireies 

1. To list all available models in your application, you can use the following command:
   ```
   ActiveRecord::Base.connection.tables
   ```

   note that there are no tables

2. To view the schema of a particular table (e.g., "users"), you can use the `columns` method:


3. To perform custom queries, you can utilize the `find_by_sql` method. It

### create a table

To create a table in your Ruby on Rails application, you would typically create a migration file and then run the migration. Here's how you can do it:

1. Open your terminal or command prompt.
2. Navigate to the root directory of your Rails application using the 'cd' command, if you are not already there.
3. Generate a migration file using the `rails generate migration` command, followed by the name of the migration and the fields you want to include. For example, to create a "users" table with columns for name and email, use the following command:
   ```
   rails generate migration CreateUsers name:string email:string
   ```
   This will generate a migration file in the `db/migrate` directory.

4. Open the generated migration file, located in the `db/migrate` folder, with a text editor. You will find a method called `change`, which allows you to define the database changes you want to make. In this case, it will create a "users" table with the specified fields.

5. Inside the `change` method, use the `create_table` method to define your table. For example:
   ```ruby
   def change
     create_table :users do |t|
       t.string :
       name
       t.string :email
       t.timestamps
     end
   end
   ```

6. Save the migration file and exit the text editor.

7. Run the migration using the `rails db:migrate` command. This will execute the migration and create the "users" table in your database.
   ```
   rails db:migrate
   ```

8. enter the console and check for tables again

  ```
   ActiveRecord::Base.connection.tables
```

