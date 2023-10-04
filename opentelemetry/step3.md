# Step 3

## .net and zipkin

WIP install core 2.0 first, below


1. `wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb`{{exec}}
2. `sudo dpkg -i packages-microsoft-prod.deb`{{exec}}
3. `rm packages-microsoft-prod.deb`{{exec}}
4. `sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0`{{exec}}
5. `sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-7.0`{{exec}}
6. `dotnet --info`{{exec}}

## Step 3.3

1. `cd ~`{{exec}}
3. `git clone https://github.com/openzipkin/zipkin4net.git`{{exec}}
2. `cd cd zipkin4net/`{{exec}}
4. `ls`{{exec}}
5. `pwd`{{exec}}

## install dotnet core 2

https://dotnet.microsoft.com/en-us/download/dotnet/2.0

1. `wget https://download.microsoft.com/download/f/c/1/fc16c864-b374-4668-83a2-f9f880928b2d/dotnet-sdk-2.1.202-linux-x64.tar.gz`{{exec}}
2. `mkdir -p $HOME/dotnet && tar zxf dotnet-sdk-2.1.202-linux-x64.tar.gz -C $HOME/dotnet`{{exec}}
3. `export DOTNET_ROOT=$HOME/dotnet`{{exec}}
4. `export PATH=$PATH:$HOME/dotnet`{{exec}}

5. edit build.sh 
6. `./build.sh`{{exec}}




