
# Initial Setup

## Install Ruby-on-Rails

`sudo apt update`{{exec}}

`sudo apt install -y  postgresql postgresql-contrib sqlite3`{{exec}}

`sudo systemctl start postgresql.service`{{exec}}

---

### install asdf

`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2`{{exec}}

`. "$HOME/.asdf/asdf.sh"`{{exec}}

`echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc`{{exec}}

`. "$HOME/.asdf/completions/asdf.bash"`{{exec}}

`echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc`{{exec}}

`asdf current`{{exec}}

### install ruby



`asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git`{{exec}}

`asdf plugin list all | grep ruby`{{exec}}

`asdf current`{{exec}}

`asdf list all ruby`{{exec}}

Now we'll install ruby 3.1.2, which will take about 10 minutes 

`asdf install ruby 3.1.2`{{exec}} 

Now we need to set which version of ruby to use, and the [context](https://asdf-vm.com/guide/getting-started.html#global):

- global: sets for the entire machine from $HOME/.tool-versions
- shell: sets
- local: sets working directory version with $PWD/.tool-versions

`asdf global ruby 3.1.2`{{exec}}

`asdf current`{{exec}}

`ruby -v`{{exec}}

---

WIP to old `sudo apt install -y ruby-full`{{copy}}

see the asdf lab for details on custom installs of ruby.


To install Ruby on Rails on Ubuntu, you can follow these steps:

Step 1: Update system packages

`sudo apt update`{{exec}}

Step 2: Install Ruby using rbenv

WIP rbenv install 2.7.2 takes too long


`sudo apt install -y git curl libssl-dev libreadline-dev zlib1g-dev`{{exec}}   
`git clone https://github.com/rbenv/rbenv.git ~/.rbenv`{{exec}}   
`git clone https://github.com/rbenv/rbenv.git ~/.rbenv`{{exec}}   
`echo 'eval "$(rbenv init -)"' >> ~/.bashrc`{{exec}}   
`source ~/.bashrc`{{exec}}   
`git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build`{{exec}}    
`rbenv install 2.7.2`{{exec}}   
`rbenv global 2.7.2`{{exec}}   

---



Step 3: Install Rails
`gem install rails`{{exec}}

Step 4: Verify installation
```
ruby -v
rails -v
```{{exec}}

Now that you have Rails installed, let's create a demo app:

Step 5: Create a new Rails application
```
rails new demo_app
cd demo_app
```{{exec}}

Step 6: Start the Rails server
```
rails server -b 0.0.0.0
```{{exec}}

Now you can access the demo app by opening a web browser and visiting `http://localhost:3000`.

On killacode: {{TRAFFIC_HOST1_3000}}

### To remove the warning
add __config.hosts.clear__ to the  `config/environments/development.rb` file`, in the 'do' section

This will create a basic Rails application with the necessary files and directories. You can explore the generated code and start building your lab exercises based on the sections mentioned earlier.


## Hello world

Let add 'Hello world'

https://guides.rubyonrails.org/getting_started.html#say-hello-rails





# For links to ports:

```
Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_80}}
Link for traffic into host 2 on port 4444
{{TRAFFIC_HOST2_4444}}
Link for traffic into host X on port Y
{{TRAFFIC_HOSTX_Y}}
```



