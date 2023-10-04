# Step 3

## .net and zipkin


1. `wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb`{{exec}}
2. `sudo dpkg -i packages-microsoft-prod.deb`{{exec}}
3. `rm packages-microsoft-prod.deb`{{exec}}
4. `sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0`{{exec}}
5. `sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-7.0`{{exec}}
6. `dotnet --info`{{exec}}

## Step 3.3
1. `apt-get update`{{exec}}
2. `halt`{{exec}}
3. `git clone https://github.com/openzipkin/zipkin4net.git`{{exec}}
4. `ls`{{exec}}
5. `pwd`{{exec}}
6. `./build.sh`{{exec}}
7. `history`{{exec}}



## setp 3.1
    wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    9  sudo dpkg -i packages-microsoft-prod.deb
   10  rm packages-microsoft-prod.deb
   11  sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0
   12  sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-7.0
   13  dotnet --inf

   WIP I think this is the wrong version of .net


## step 3.3

  apt-get update
    2  halt
    3  git clone  https://github.com/openzipkin/zipkin4net.git
    4  ls
    5  pwd
    6  ./build.sh 
    7  history