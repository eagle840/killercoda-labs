# python


```
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.4

# For Ubuntu or other linux distros
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
```{{exec}}

`bash`{{exec}}

`asdf plugin-add python`{{exec}}


`asdf install python 3.7.4`{{exec}}

# Dapr Tutorials



https://docs.dapr.io/getting-started/tutorials/



# Dapr Quick Start

https://docs.dapr.io/getting-started/quickstarts/

## Publish and Subscribe

https://docs.dapr.io/getting-started/quickstarts/pubsub-quickstart/

`git clone https://github.com/dapr/quickstarts.git`{{exec}}


`cd pub_sub/python/sdk`{{exec}}

`dapr run -f .`{{exec}}