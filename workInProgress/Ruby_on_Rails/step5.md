# Authentication and Authorization

Sure! Here's an example code snippet for Section 5, which covers authentication and authorization using Devise and CanCanCan gems in Ruby on Rails:

1. Install Devise and CanCanCan gems by adding them to your Gemfile and running `bundle install`.

2. Generate the User model and Devise views by running the following commands:
```bash
rails generate devise:install
rails generate devise User
rails generate devise:views
```

3. Configure the User model with Devise authentication options in `app/models/user.rb`:
```ruby
class User < ApplicationRecord
  # Include default devise modules: :database_authenticatable, :registerable,
  # :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
```

4. Create a new migration to add a `role` column to the `users` table:
```bash
rails generate migration AddRoleToUsers role:string
```

5. Run the migration to update the database schema:
```bash
rails db:migrate
```

6. Generate an Ability class for CanCanCan in `app/models/ability.rb` to define user roles and permissions:
```ruby
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :read, :all
    end
  end
end
```

7. Add a `role` attribute to the user registration form in `app/views/devise/registrations/new.html.erb`:
```erb
<div class="field">
  <%= f.label :role %>
  <%= f.select :role, options_for_select([['User', 'user'], ['Admin', 'admin']]) %>
</div>
```

8. Update the `application_controller.rb` to handle authorization using CanCanCan:
```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  load_and_authorize_resource
end
```

9. Add authorization checks in your views or controllers using CanCanCan's `can?` method:
```ruby
<% if can? :manage, @post %>
  <%= link_to 'Edit', edit_post_path(@post) %>
  <%= link_to 'Delete', post_path(@post), method: :delete, data: { confirm: 'Are you sure?' } %>
<% end %>
```

In this example, we added a `role` column to the `users` table, configured Devise for authentication, and used CanCanCan to define user roles and permissions. The `Ability` class determines what actions each role can perform. The `role` attribute is added to the user registration form, and the `application_controller.rb` is updated to handle authorization. Finally, we added an authorization check in a view to show or hide certain actions based on the user's role.