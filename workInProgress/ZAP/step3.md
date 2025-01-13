
# From command line:



**Format**
  ```
  docker run --rm \
     -v $(pwd):/zap/wrk/:rw \
     -u $(id -u):$(id -g) \
     -t ghcr.io/zaproxy/zaproxy:stable \
     zap-baseline.py \
     -t http://localhost:80 \
     -g gen.conf \
     -x OWASP-ZAP-Report.xml \
     -r scan-report.html
  ```{{exec}}


`Docker run [docker options] (ZAP Image) (Packaged Scan Name) -t (target) [zap options]`

`zap-baseline.py`, `zap-full-scan.py` and `zap-api-scan.py`

-m # the number of minutes to spider
-a  include alpha rules (passive for baseline, active for full)
-j  use AJAX spider in addition

-r (file)report: html format
-J (file)report: json format
-x (file)report: xml format
-w (file)report: markdown format

  to debug the run:

  ```
  docker run --rm \
     -v $(pwd):/zap/wrk/:rw \
     -u $(id -u):$(id -g) \
     -t ghcr.io/zaproxy/zaproxy:stable \
     zap-baseline.py -d \
     -t http://localhost:80 \
     -g gen.conf \
     -x OWASP-ZAP-Report.xml \
     -r scan-report.html
  ```{{exec}}




## Example ouput:

```
  Total of 2 URLs
PASS: Vulnerable JS Library (Powered by Retire.js) [10003]
PASS: In Page Banner Information Leak [10009]
PASS: Cookie No HttpOnly Flag [10010]
PASS: Cookie Without Secure Flag [10011]
PASS: Re-examine Cache-control Directives [10015]
PASS: Cross-Domain JavaScript Source File Inclusion [10017]
PASS: Content-Type Header Missing [10019]
PASS: Anti-clickjacking Header [10020]
PASS: X-Content-Type-Options Header Missing [10021]
PASS: Information Disclosure - Debug Error Messages [10023]
PASS: Information Disclosure - Sensitive Information in URL [10024]
PASS: Information Disclosure - Sensitive Information in HTTP Referrer Header [10025]
PASS: HTTP Parameter Override [10026]
PASS: Information Disclosure - Suspicious Comments [10027]
PASS: Open Redirect [10028]
PASS: Cookie Poisoning [10029]
...

...
PASS: Application Error Disclosure [90022]
PASS: WSDL File Detection [90030]
PASS: Loosely Scoped Cookie [90033]
FAIL-NEW: 0     FAIL-INPROG: 0  WARN-NEW: 0     WARN-INPROG: 0  INFO: 0 IGNORE: 0       PASS: 65
```

---


To allow zap to write to a local directory:

`mkdir zap-reports/`{{exec}}

`chmod +777 zap-reports/`{{exec}}


For the upcoming reports:

`python -m http.server 8000 -d ./zap-reports/`{{exec}}




## running base line scan


docs: https://www.zaproxy.org/docs/docker/baseline-scan/

`docker run -v $(pwd):/zap/wrk/:rw -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t https://www.example.com -g gen.conf -r testreport.html`{{copy}}


`docker run -v $(pwd)/zap-reports:/zap/wrk/:rw -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t http://localhost:8000 -g gen.conf -r basehttpserverreport.html`{{exec}}


WIP look ling can't access localhost this wey?:
`docker run -v $(pwd)/zap-reports:/zap/wrk/:rw -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t http://localhost:3000 -g gen.conf -r baseJSreport.html`{{exec}}

`docker run -v $(pwd)/zap-reports:/zap/wrk/:rw -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t {{TRAFFIC_HOST1_3000}} -g gen.conf -r baseJSreport.html`{{exec}}

`ls zap-reports/`{{exec}}

Review the report on

{{TRAFFIC_HOST1_8000}}

## Running an api scan

https://www.zaproxy.org/docs/docker/api-scan/

Blog: https://www.zaproxy.org/blog/2017-06-19-scanning-apis-with-zap/

Uses: `zap-api-scan.py`

`docker run -v $(pwd)/zap-reports:/zap/wrk/:rw -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t {{TRAFFIC_HOST1_3000}} -g gen.conf -r apiJSreport.html`{{exec}}


WIP Or this?:
`docker run -v $(pwd)/zap-reports:/zap/wrk/:rw -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t {{TRAFFIC_HOST1_3000}}/rest -g gen.conf -r apiJSreport.html`{{exec}}

`ls zap-reports/`{{exec}}

Review the report on

{{TRAFFIC_HOST1_8000}}

## Full scan

https://www.zaproxy.org/docs/docker/full-scan/

WIP: Unknown time, over 20mins to run?

Uses `zap-full-scan.py`


`docker run -v $(pwd)/zap-reports:/zap/wrk/:rw -t ghcr.io/zaproxy/zaproxy:stable zap-full-scan.py -t {{TRAFFIC_HOST1_3000}} -g gen.conf -r fullJSreport.html`{{exec}}

`ls zap-reports/`{{exec}}

Review the report on

{{TRAFFIC_HOST1_8000}}
