# Step 3  Routing and Views

Sure! Here's an example code snippet for Section 3, along with a description of each step:

Step 1: Understanding the routing mechanism in Rails
- Open the `config/routes.rb` file in your Rails application.
- You'll see a block of code that defines the routes for your application.
- By default, Rails uses RESTful routing conventions, mapping HTTP verbs to controller actions.

Step 2: Creating custom routes and route constraints
- Add a custom route to the `routes.rb` file, for example:
  ```ruby
  get '/about', to: 'pages#about'
  ```
- This route maps the `/about` URL to the `about` action in the `PagesController`.

Step 3: Generating views and using ERB templates
- Create a new file `about.html.erb` in the `app/views/pages` directory.
- This file will contain the HTML code for the "About" page.
- You can use ERB (Embedded Ruby) syntax to embed dynamic content in the HTML.

Step 4: Working with forms and form helpers
- In the `app/views/pages/about.html.erb` file, add a form to collect user input:
  ```html
  <%= form_tag '/contact', method: :post do %>
    <%= label_tag :name, 'Name:' %>
    <%= text_field_tag :name %>

    <%= label_tag :email, 'Email:' %>
    <%= email_field_tag :email %>

    <%= submit_tag 'Submit' %>
  <% end %>
  ```
- This form uses Rails form helpers to generate the HTML form elements.
- The form will be submitted to the `/contact` URL using the POST method.

This example demonstrates how to create a custom route, generate a view template, and work with forms in Rails. You can build upon this code to create more complex views and forms in your lab.