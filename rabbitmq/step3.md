# check the queues

In this step we'll create two workers, and send messages to them.

`docker exec some-rabbit rabbitmqctl list_queues`{{execute}}


# work queues

https://www.rabbitmq.com/tutorials/tutorial-two-python.html

### Setup worker nodes

Lets look at a 'worker node'

`cat worker.py`{{execute}}

open a couple of terminals and then run a worker in teach.

`python3 worker.py`{{execute}}

# Create messages to process

in the orginal terminal window you can start sending tasks.

each . represents a second that the work will 'work', ie sleep.

`python3 new_task.py First message.`{{execute}}

`python3 new_task.py Second message..`{{execute}}

`python3 new_task.py Third message...`{{execute}}

`python3 new_task.py Fourth message....`{{execute}}

`python3 new_task.py Fifth message.....`{{execute}}

you can run these tasks as many times as you want and see them go through the rabbit mq management console.

