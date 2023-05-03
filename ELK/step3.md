

==========   

# CRUD Operations

## basic setup


Using the same 'Dev Tool'

create an index  `PUT favorite_candy`{{copy}}

the response `"acknowledged" : true,` shows the operation was successful

and you should see the http response code, and the time taken above that section in green and white.

to list all indices `GET /_cat/indices`{{copy}}

in kibana Home>stack mgmnt > Data > Index Mmgmnt

Now index a document (??? adding a document to an index ?)

```
POST favorite_candy/_doc
{
  "first_name": "Lisa",
  "candy": "Sour Skittles"
}
```{{copy}}

if you want to do a document with a specific ID (1)

```
PUT favorite_candy/_doc/1
{
  "first_name": "John",
  "candy": "Starburst"
}
```{{copy}}

in the output, pay attention to the version number

add and run the following:

```
PUT favorite_candy/_doc/2
{
  "first_name": "Rachel",
  "candy": "Rolos"
}
PUT favorite_candy/_doc/3
{
  "first_name": "Tom",
  "candy": "Sweet Tarts"
}
```{{copy}}

Lets read one of the docs

`GET favorite_candy/_doc/1`{{copy}}

- you can see the _source in the output is the document

Now if you just to resend the same id, it will over write and give you an incremented version number

```
PUT favorite_candy/_doc/1
{
  "first_name": "Sally",
  "candy": "Snickers"
}
```{{copy}}

If you want to lock a document so it can't be updated, use:

```
PUT favorite_candy/_create/1
{
  "first_name": "Finn",
  "candy": "Jolly Ranchers"
}
```{{copy}}

Now this will fail since a document with that id already exsists

### update

Now to update a specific document use:

```
POST favorite_candy/_update/1
{
  "doc": {
    "candy": "M&M's"
  }
}
```
- note the id number,
- the 'doc' 
- the fields you wish updated
- that the response shows an incremented version number

### delete

`DELETE favorite_candy/_doc/1`{{exec}}

to delete a complete index

`DELETE favorite_candy`


## CRUD through http

## send data through http api


`cd ~`

`mkdir bin`

`cd bin`

`nano curl`

```
#!/bin/bash
/usr/bin/curl -H "Content-Type: application/json" "$@"
```

`chmod a+x curl`

`cd ~`

`source .profile`


```
type 'curl -XPUT localhost:9200/movies/ -d'  
```  

note the quotes in the commands that encapsulated the json data

then 
`{`
ctrl-v tab, and complete as below. Notice the single quotes enclosing the text

```
{
  "mappings": {
    "properties": {
      "year": { "type": "date" }
    }
  }
}'
```
ABOVE ISN'T WORKING,, need to be in the ~/bin dir and run ./curl

curl -H "Content-Type: application/json" -XPUT localhost:9200/movies -d '
> {
>   "mappings": {
>     "properties": {
>       "year": { "type": "date" }
>     }
>   }
> }'



`curl -XGET localhost:9200/movies/_mapping`



`wget http://media.sundog-soft.com/es8/movies.json`



`cat movies.json`

note the json file already has the 'create', 'index' and 'id'
and that a year field is present, and we have told ES to treat that as a date.

curl -H "Content-Type: application/json" -XPUT localhost:9200/_bulk?pretty --data-binary @movies.json


curl -XGET localhost:9200/movies/_search?pretty`




