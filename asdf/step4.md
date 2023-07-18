## Debug rails

https://guides.rubyonrails.org/debugging_rails_applications.html

if you look at the Gemfile for the rails app you've installed,

you'll notice the following gems:#
- byebug
- web-console

in one of the controller methods, add 'console' and the web gui will give a console


## console 

In the Ruby on Rails console, you can use various commands and techniques to help with debugging and troubleshooting. Here are some commonly used commands:

1. `puts` or `print`: You can use these commands to print out values or messages to the console, allowing you to inspect variables or track the flow of your code.

2. `p`: Similar to `puts` or `print`, the `p` command is useful for inspecting variables and objects. It provides more detailed output, including the object's class and structure.

3. `raise`: You can use the `raise` command to raise an exception or error at a specific point in your code. This can help you identify where an issue occurs and see the backtrace of the error.

4. `debugger`: By placing the `debugger` command at a specific line in your code, you can trigger a breakpoint. This will pause the execution of your program at that point, allowing you to inspect variables, step through code, and diagnose issues interactively.

5. `binding.pry`: If you have the `pry` gem installed, you can use the `binding.pry` command to insert a breakpoint in your code. This will open a Pry console at that point, enabling you to explore the state of your application and execute commands interactively.

6. `logger`: The `logger` object allows you to write logs to the Rails log file. You can use various log levels (`debug`, `info`, `warn`, `error`, `fatal`) to output messages at different levels of severity. This can be helpful for tracking the flow of your application and troubleshooting issues.

These commands can help you gain insights into your code, identify errors, and understand the behavior of your application during runtime.

WIP
- 'rails console --sandbox'
- web-console gem  https://rubygems.org/gems/web-console
- pry gem https://rubygems.org/gems/pry-rails
- byebug gem https://rubygems.org/gems/byebug