# sqlmap

https://sqlmap.org/

see thm https://tryhackme.com/room/sqlmap

## What is it

SQLMap is an open-source penetration testing tool that automates the process of detecting and exploiting SQL injection vulnerabilities in web applications. It is designed to help security professionals and developers identify and fix SQL injection vulnerabilities in their applications. SQLMap can be used to perform various tasks such as fingerprinting the database, extracting data from the database, and even gaining remote code execution on the server. It supports a wide range of database systems including MySQL, Oracle, PostgreSQL, Microsoft SQL Server, and more.

##

`git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev`{{exec}}


`git clone https://github.com/sqlmapproject/sqlmap`{{copy}} WIP

## Usage

`python sqlmap.py -h`{{exec}}

`sqlmap -h`{{exec}}

## Basic Commands

| Command | Description |
|---------|-------------|
| `sqlmap -u <URL>` | Perform a basic SQL injection test on the specified URL |
| `sqlmap -r <request_file>` | Perform a basic SQL injection test using a request file |
| `sqlmap -g <parameter>` | Test all GET parameters for SQL injection vulnerabilities |
| `sqlmap -p <parameter>` | Test a specific parameter for SQL injection vulnerabilities |
| `sqlmap --cookie=<cookie_string>` | Use a specific cookie string for the request |
| `sqlmap --level=<level>` | Set the level of tests to be performed (1-5, with 5 being the most thorough) |
| `sqlmap --risk=<risk>` | Set the risk level of tests to be performed (1-3, with 3 being the most aggressive) |
| `sqlmap --dbms=<dbms>` | Specify the database management system to be tested |
| `sqlmap --os=<os>` | Specify the operating system to be tested |
| `sqlmap --threads=<threads>` | Set the number of concurrent HTTP requests to be made |
| `sqlmap --dump` | Dump the contents of the database |
| `sqlmap --tables` | Enumerate the tables in the database |
| `sqlmap --columns -T <table>` | Enumerate the columns in a specific table |
| `sqlmap --dump -T <table> -C <column>` | Dump the contents of a specific table and column |
| `sqlmap --os-shell` | Get an interactive operating system shell on the target server |

##

`sqlmap -u localhost:1234` --dbs