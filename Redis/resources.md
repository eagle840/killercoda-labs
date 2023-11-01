

--- uni --

basic

keys & expriration
- upto 512MB in size
- logical databases, start at [0], cluster only has [0]
- case senistive
- customer:1000  is considered the key, you'd put a space and then the value
>get

>scan slot [MATCH pattern] [COUNT count]


| keys | scan |
|------|------|
| Blocks until complete |  iterates using a cursor |
| Never use in production | returns a reference |
|Usful for debugging | may return 0 or more keys per cell |
| | safe for production |

strings

hashes (K;v)

## sets

Lists
