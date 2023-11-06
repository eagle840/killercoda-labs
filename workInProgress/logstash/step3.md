# advanced gork 

http://grokconstructor.appspot.com/


https://www.elastic.co/guide/en/logstash/7.17/plugins-filters-grok.html

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

%{Pattern_name:Field_name:optional_type}

(type: int and float, default is string)

%{NUMBER:num:float}



## creating your own pattern

If one of the 200 logstash grok patterns don't match you need, you can create your own pattern with

```
(?<custom_field>custom pattern)
```

For example:

(?\d\d-\d\d-\d\d)

This grok pattern will match the regex of 22-22-22 (or any other digit) to the field name.
