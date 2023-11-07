# Hello World! using python

pulled from: https://www.startdataengineering.com/post/dbt-data-build-tool-tutorial/

First update docker and compose


`apt install -y  pgcli tree`{{exec}}

`pip install dbt-postgres`{{exec}}

`pip install dbt-core`{{exec}}





`git clone https://github.com/josephmachado/simple_dbt_project.git`{{exec}}

`cd simple_dbt_project`{{exec}}

this sets the profile file, which is in this directry

`export DBT_PROFILES_DIR=$(pwd)`{{exec}}

start the postgres server, which also pulls data from 'raw_data' and 'warehouse_setup'

`docker compose up -d`{{exec}}

check for problems:


`cd sde_dbt_tutorial/`{{exec}}

`dbt debug`{{exec}}

`dbt snapshot`{{exec}}

`dbt run`{{exec}}

`dbt docs generate`{{exec}}

`dbt docs serve`{{exec}}
 


