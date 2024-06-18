# tensor Flow

`pip3 install tensorflow`{{exec}}


https://www.tensorflow.org/tutorials/quickstart/beginner


`python`{{exec}}


`import tensorflow as tf`{{exec}}


`print("TensorFlow version:", tf.__version__)`{{exec}}



`mnist = tf.keras.datasets.mnist`{{exec}}


`(x_train, y_train), (x_test, y_test) = mnist.load_data()`{{exec}}


`x_train, x_test = x_train / 255.0, x_test / 255.0`{{exec}}


Build a machine learning model
```
model = tf.keras.models.Sequential([
  tf.keras.layers.Flatten(input_shape=(28, 28)),
  tf.keras.layers.Dense(128, activation='relu'),
  tf.keras.layers.Dropout(0.2),
  tf.keras.layers.Dense(10)
])
```{{exec}}

`predictions = model(x_train[:1]).numpy()`{{exec}}


`predictions`{{exec}}


SHOULD RETURN
 ```
array([[ 0.7376794 ,  0.49447078,  0.10823108,  0.02784834, -0.03891648,
        -0.36803806, -0.00216345, -0.04204601, -0.67150915, -1.0418724 ]],
      dtype=float32)

 ```

`tf.nn.softmax(predictions).numpy()`{{exec}}




`quit()quit()`{{exec}}

# transformers

`pip3 install transformers`{{exec}}

run 'quick tour' in https://pypi.org/project/transformers/


`python`{{exec}}


`from transformers import pipeline`{{exec}}

`classifier = pipeline('sentiment-analysis')`{{exec}}

`classifier('We are very happy to introduce pipeline to the transformers repository.')`{{exec}}

SHOULD RETURN

```
[{'label': 'POSITIVE', 'score': 0.9996980428695679}]

```

`quit()`{{exec}}
