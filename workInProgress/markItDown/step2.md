# Send some simple messages to Rabbitmq

https://www.rabbitmq.com/tutorials/tutorial-one-python.html

We need to install the pika python package:

`pip3 install pika`{{execute}}

https://pypi.org/project/pika/


Now send a message to RabbitMQ:

`python3 send.py`{{execute}}

If you jump over to the management page, you'll see the msg in the queue in the Overview and the Queues tab.

Let's receive that msg in a new terminal window,

`python3 receive.py`{{execute T2}}

 Lets another terminal and exe send 3 times:

`python3 send.py`{{execute}}

In the orginal terminal you'll see them coming back, and the msg rate's in the mgmnt console changing.

Ctrl-C to exit the program

