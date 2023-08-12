# Step 4 Database Integration

Sure! Here's an example code snippet for Section 4: Database Integration, along with a description of each step:

Step 1: Configuring database connection in Rails
- Open the `config/database.yml` file in your Rails application.
- Update the `development`, `test`, and `production` sections with the appropriate database credentials (e.g., username, password, host, etc.).
- Specify the database adapter (e.g., `mysql2`, `postgresql`, `sqlite3`, etc.) based on your database choice.

Step 2: Creating database tables and associations
- Create a new model using the Rails generator command: `rails generate model User name:string email:string`.
- This will generate a migration file in the `db/migrate` directory.
- Open the migration file and define the table structure and any additional columns or constraints.
- Run the migration using the command: `rails db:migrate`.
- This will create the `users` table in the database.

Step 3: Performing database queries using ActiveRecord
- Open the corresponding model file (e.g., `app/models/user.rb`).
- Define the associations between models using `has_many`, `belongs_to`, etc.
- Implement custom methods for querying the database, such as finding users by name or email.
- Use ActiveRecord methods like `create`, `find`, `where`, `update`, `destroy`, etc., to perform database operations.

Step 4: Implementing validations and callbacks
- Add validation rules to the model to ensure data integrity (e.g., presence, uniqueness, length, format, etc.).
- Use ActiveRecord callbacks like `before_save`, `after_create`, etc., to perform actions before or after certain events (e.g., saving, creating, updating, etc.).

Here's an example code snippet for the `User` model:

```ruby
# app/models/user.rb

class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :posts
end
```

In this example, we have defined a `User` model with validations for the `name` and `email` attributes. The `name` attribute must be present and have a maximum length of 50 characters. The `email` attribute must be present, unique, have a maximum length of 255 characters, and match the email format using a regular expression. Additionally, we have defined a one-to-many association between `User` and `Post` models using `has_many` association.

You can further enhance the model with additional validations, associations, or custom methods based on your requirements.