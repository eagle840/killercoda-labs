
# Initial Setup

## Install dependiences 

`sudo apt update`{{exec}}

`sudo apt install -y  postgresql postgresql-contrib sqlite3`{{exec}}

`sudo systemctl start postgresql.service`{{exec}}

`apt-get install -y libyaml-dev`{{exec}}

## user setup

To ensure smooth operation of Ruby applications, we'll create a dedicated user named 'koda':

`sudo adduser --gecos "" koda`{{exec}}

The `--gecos ""` option allows you to bypass the prompts for additional user information

`sudo adduser koda sudo`{{copy}}

`login koda`{{exec}}

---

## install asdf (appears to be fastest setup)

`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2`{{exec}}

`. "$HOME/.asdf/asdf.sh"`{{exec}}

`echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc`{{exec}}

`. "$HOME/.asdf/completions/asdf.bash"`{{exec}}

`echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc`{{exec}}

`asdf current`{{exec}}

## install ruby

Warning: this can take upto 10 mins



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

WIP `gem update`{{exec}}

`apt install irb -y`{{exec}}


##  Install Rails

`gem install rails`{{exec}}

Step 4: Verify installation

`rails -v`{{exec}}

Now that you have Rails installed, let's create a demo app:

## Create a new Rails application

`rails new demo_app`{{exec}}
`cd demo_app`{{exec}}


Start the Rails server

`rails server -b 0.0.0.0`{{exec}}


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



