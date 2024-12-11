# pytest


https://docs.pytest.org/en/stable/getting-started.html


`pip install -U pytest`{{exec}}


`pytest --version`{{exec}}

`touch test_sample.py`{{exec}}

```
# content of test_sample.py
def func(x):
    return x + 1


def test_answer():
    assert func(3) == 5
```


`pytest`{{exec}}
