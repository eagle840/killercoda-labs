# Install spark and tools

Lets update Ubuntu first:

`sudo apt-get update`{{execute}}

For full functionality, spark needs java 8

`apt install -y default-jre`{{exec}}

`java -version`{{execute}}

We'll also need python:
`python -V`{{execute}}
 and python 3
 `python3 -V`{{execute}}

and update it:
`pip install --upgrade pip`{{execute}}


Download Spark :


`curl -O https://dlcdn.apache.org/spark/spark-3.5.4/spark-3.5.4-bin-hadoop3.tgz`{{exec}}



extract it:

`tar -xvf spark-3.5.4-bin-hadoop3.tgz`{{exec}}


And set it up for execution:
`mv spark-3.5.4-bin-hadoop3/usr/local/spark`{{exec}}


`export SPARK_HOME=/usr/local/spark`{{execute}}

`export PATH=$PATH:$SPARK_HOME/bin`{{execute}}


And finally lets check spark (for scala) is installed and working:
`spark-shell --version`{{execute}}

and for python:
`pyspark --version`{{execute}}
