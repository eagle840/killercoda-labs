# advanced gork 

when you need to match different patterns


```
grok {
  match => {
    "fieldname" => [
      "pattern1",
      "pattern2",
      ...,
      "patternN"
    ]
  }
}
```