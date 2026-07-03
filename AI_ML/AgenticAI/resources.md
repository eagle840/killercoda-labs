# old code

`docker exec -it $(docker ps --format '{{json .}}' | jq -r .ID) cat /root/.local/share/jupyter/runtime/notebook_cookie_secret`{{execute T2}}
 
