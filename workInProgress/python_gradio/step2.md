# tensor Flow

pip install tensorflow


https://www.tensorflow.org/tutorials/quickstart/beginner


python

```
Python 3.8.10 (default, Nov 22 2023, 10:22:35) 
[GCC 9.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import tensorflow as tf
2024-06-18 06:54:26.304752: I tensorflow/tsl/cuda/cudart_stub.cc:28] Could not find cuda drivers on your machine, GPU will not be used.
2024-06-18 06:54:26.737214: I tensorflow/tsl/cuda/cudart_stub.cc:28] Could not find cuda drivers on your machine, GPU will not be used.
2024-06-18 06:54:28.074444: W tensorflow/compiler/tf2tensorrt/utils/py_utils.cc:38] TF-TRT Warning: Could not find TensorRT
>>> print("TensorFlow version:", tf.__version__)
TensorFlow version: 2.13.1
>>> mnist = tf.keras.datasets.mnist
>>> (x_train, y_train), (x_test, y_test) = mnist.load_data()
Downloading data from https://storage.googleapis.com/tensorflow/tf-keras-datasets/mnist.npz
11490434/11490434 [==============================] - 1s 0us/step
>>> x_train, x_test = x_train / 255.0, x_test / 255.0
>>> model = tf.keras.models.Sequential([
...   tf.keras.layers.Flatten(input_shape=(28, 28)),
...   tf.keras.layers.Dense(128, activation='relu'),
...   tf.keras.layers.Dropout(0.2),
...   tf.keras.layers.Dense(10)
... ])
>>> predictions = model(x_train[:1]).numpy()
>>> predictions
array([[ 0.7376794 ,  0.49447078,  0.10823108,  0.02784834, -0.03891648,
        -0.36803806, -0.00216345, -0.04204601, -0.67150915, -1.0418724 ]],
      dtype=float32)
>>> tf.nn.softmax(predictions).numpy()
array([[0.2020839 , 0.15845558, 0.10768761, 0.09937017, 0.09295236,
        0.06688438, 0.09643219, 0.09266191, 0.04937748, 0.03409433]],
      dtype=float32)
>>> 
```

# transformers

pip install transformers

run 'quick tour' in https://pypi.org/project/transformers/
