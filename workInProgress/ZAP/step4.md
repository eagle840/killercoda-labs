STep 4

#Targets


Bodgelt:    docker pull psiinon/bodgeit

OWASP JuiceShop:    docker pull bkimminich/juice-shop

OWASP JuiceShop (herokuapp):

https://ps-juiceshop-05c17cab9c2f.herokuapp.com

https://juice-shop.herokuapp.com/

# with webswing

`docker run -u zap -p 8080:8080 -p 8090:8090 -i ghcr.io/zaproxy/zaproxy:stable zap-webswing.sh`{{execute}}

goto /zap/ url

once open

Tools>options>API  note api key value

- Add address' to define what others can access (localhost only by default)

## command line

Packaged Scans - Usage & Options


`Docker run [docker options] (ZAP Image) (Packaged Scan Name) -t (target) [zap options]`

`zap-baseline.py` and `zap-full-scan.py`

-m # the number of minutes to spider
-a  include alpha rules (passive for baseline, active for full)
-j  use AJAX spider in addition

-r (file)report: html format
-J (file)report: json format
-x (file)report: xml format
-w (file)report: markdown format

https: //www.zaproxy.org/docs/docker/


`zap-api-scan.py`

-f     format (openai, soap, graphql)
-a    include alpha passive scan rules
