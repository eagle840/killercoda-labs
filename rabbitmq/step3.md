# check the queues

`docker exec some-rabbit rabbitmqctl list_queues`{{execute}}


# work queues

https://www.rabbitmq.com/tutorials/tutorial-two-python.html

# open 2 terminals and run in each


`cat worker.py`{{execute}}


open a couple of terminals and and run the worker in them.

`python3 worker.py`{{execute}}

# in another

in the orginal terminal window you can start sending tasks.

each . represents a second that the work will 'work', ie sleep.

`python3 new_task.py First message.`{{execute}}

`python3 new_task.py Second message..`{{execute}}

`python3 new_task.py Third message...`{{execute}}

`python3 new_task.py Fourth message....`{{execute}}

`python3 new_task.py Fifth message.....`{{execute}}

you can run these tasks as many times as you want and see them go through the rabbit mq management console.

