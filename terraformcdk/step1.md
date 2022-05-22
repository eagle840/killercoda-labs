# initial setup

You'll need:

- npm (node packet manager)
- pipenv
- tf client
- python


## install terraform
`sudo apt update`{{execute}}    

`curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -`{{execute}}    

`apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"`{{execute}}  


`apt install terraform`{{execute}}    

`terraform version`{{execute}}    

## install cdk
`npm install --global cdktf-cli`{{execute}}    
  
`cdktf help`{{execute}}    

` cdktf deploy help`{{execute}}    

`touch ~/.bashrc`{{execute}}    

`terraform -install-autocomplete`{{execute}}    

`exec bash`{{execute}}

  

   
