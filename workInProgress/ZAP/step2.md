# ZAP


https://www.zaproxy.org/docs/docker/about/


# with webswing

`docker run -u zap -p 8080:8080 -p 8090:8090 -i ghcr.io/zaproxy/zaproxy:stable zap-webswing.sh`{{execute}}

goto /zap/ url

once open

Tools>options>API  note api key value

- Add address' to define what others can access (localhost only by default)

## Modes

- safe
- protected
- standard
- ATTACK


## WINDOWS

```
##################################
# Tree window # Workspace window #
##################################
#     Information window         #
##################################

```

## Wiki/API

once the proxy is setup, a DNS host ZAP is added  :http://ZAP

ajaxsider => ajax syider
ascan     => active scan
context   => contexts
pscan     => passive scan
spider    => regular spider
reports   => reports

## Setting up SSL

In ZAP  settings> Dynamic SSL save the SSL
In Firesfox   Settings> Privacy $ Security > Certicates > view > import (check thrust websites)
  - set proxy to 127.0.0.1:8080 innc https and SOCKS

## Packaged Scans

|     | spider | AJAX Spider | Passive  | ATTACK |
|-----|--------|-------------|----------|--------|
|Basline| X | X | X |   |
|Full   | X | X | X | X |
|API    |   |   |   | X |

## workflow

Context => spider => ascan => reports

API for status  100 = completed scan

# Access the API from outside of the docker container

https://www.zaproxy.org/docs/docker/about/#accessing-the-api-from-outside-of-the-docker-container

Read and comsume this: https://www.zaproxy.org/docs/docker/about/

`docker ps`{{exec}}

what about docker pull ghcr.io/zaproxy/zaproxy:bare

`docker run -u zap -p 8080:8080 -i zaproxy/zap-stable zap.sh -daemon -port 8080 -host 0.0.0.0 -config api.disablekey=true -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true`{{exec}}


Args for starting ZAP
  -config k=v
  -daemon
  -host
  -port
  -new session # with name
  -session  # start session name

`curl    http://localhost:8080/JSON/core/view/version`{{exec}}


`touch scan_request.json`{{exec}}

`nano scan_request.json`{{exec}}

```
{
  "url": "http://example.com",
  "context": "Default Context",
  "recurse": "true",
  "inScopeOnly": "false"
}
```
need to add context: "Default Context"

WIP: list contexts

Documentation? https://www.zaproxy.org/docs/api/#api-catalogue

for the following scan: https://www.zaproxy.org/docs/api/?shell#ascanactionscan

`curl -X POST http://localhost:8080/JSON/ascan/action/scan/ -d @scan_request.json -H "Content-Type: application/json"`{{exec}}


## From command line:

html code that will result in ZAP failure

`mkdir web`{{exec}}

`nano ./web/index.html`{{exec}}

```
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OWASP ZAP Test Page</title>
</head>
<body>
<h1>OWASP ZAP Test Page</h1>
<p>This is a test page to check if OWASP ZAP is working correctly.</p>
<script>
  var maliciousCode = 'alert("XSS Attack!")';
  eval(maliciousCode);
</script>
</body>
</html>
```{{copy}}

`python3 -m http.server --directory web`{{exec}}

{{TRAFFIC_HOST1_80}}

leave the server running until the scan is complete

docs: https://docs.python.org/3/library/http.server.html


see https://www.zaproxy.org/docs/docker/baseline-scan/



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

WIP zap doesn't seem to like localhost:80

```
ERROR [Errno 5] ZAP failed to access: http://localhost:8080
2024-10-18 16:44:56,853 I/O error: [Errno 5] ZAP failed to access: http://localhost:8080
Traceback (most recent call last):
  File "/zap/zap-baseline.py", line 519, in main
    zap_access_target(zap, target)
  File "/zap/zap_common.py", line 108, in _wrap
    return_data = func(*args_list, **kwargs)
  File "/zap/zap_common.py", line 404, in zap_access_target
    raise IOError(errno.EIO, 'ZAP failed to access: {0}'.format(target))
OSError: [Errno 5] ZAP failed to access: http://localhost:8080
```

Find a site you can scan...

  the output should show to similar:

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
PASS: User Controllable Charset [10030]
PASS: User Controllable HTML Element Attribute (Potential XSS) [10031]
PASS: Viewstate [10032]
PASS: Directory Browsing [10033]
PASS: Heartbleed OpenSSL Vulnerability (Indicative) [10034]
PASS: Strict-Transport-Security Header [10035]
PASS: HTTP Server Response Header [10036]
PASS: Server Leaks Information via "X-Powered-By" HTTP Response Header Field(s) [10037]
PASS: Content Security Policy (CSP) Header Not Set [10038]
PASS: X-Backend-Server Header Information Leak [10039]
PASS: Secure Pages Include Mixed Content [10040]
PASS: HTTP to HTTPS Insecure Transition in Form Post [10041]
PASS: HTTPS to HTTP Insecure Transition in Form Post [10042]
PASS: User Controllable JavaScript Event (XSS) [10043]
PASS: Big Redirect Detected (Potential Sensitive Information Leak) [10044]
PASS: Content Cacheability [10049]
PASS: Retrieved from Cache [10050]
PASS: X-ChromeLogger-Data (XCOLD) Header Information Leak [10052]
PASS: Cookie without SameSite Attribute [10054]
PASS: CSP [10055]
PASS: X-Debug-Token Information Leak [10056]
PASS: Username Hash Found [10057]
PASS: X-AspNet-Version Response Header [10061]
PASS: PII Disclosure [10062]
PASS: Permissions Policy Header Not Set [10063]
PASS: Timestamp Disclosure [10096]
PASS: Hash Disclosure [10097]
PASS: Cross-Domain Misconfiguration [10098]
PASS: Source Code Disclosure [10099]
PASS: Weak Authentication Method [10105]
PASS: Reverse Tabnabbing [10108]
PASS: Modern Web Application [10109]
PASS: Dangerous JS Functions [10110]
PASS: Authentication Request Identified [10111]
PASS: Session Management Response Identified [10112]
PASS: Verification Request Identified [10113]
PASS: Script Served From Malicious Domain (polyfill) [10115]
PASS: Absence of Anti-CSRF Tokens [10202]
PASS: Private IP Disclosure [2]
PASS: Session ID in URL Rewrite [3]
PASS: Script Passive Scan Rules [50001]
PASS: Insecure JSF ViewState [90001]
PASS: Java Serialization Object [90002]
PASS: Sub Resource Integrity Attribute Missing [90003]
PASS: Insufficient Site Isolation Against Spectre Vulnerability [90004]
PASS: Charset Mismatch [90011]
PASS: Application Error Disclosure [90022]
PASS: WSDL File Detection [90030]
PASS: Loosely Scoped Cookie [90033]
FAIL-NEW: 0     FAIL-INPROG: 0  WARN-NEW: 0     WARN-INPROG: 0  INFO: 0 IGNORE: 0       PASS: 65
```
WIP why is there no warning/fail for the javascript?!


  `ls`{{exec}}

  Now terminate the http server, so we can review the report

  `python3 -m http.server --directory ./`{{exec}}

  {{TRAFFIC_HOST1_8000}}

## Addons

Also know as market place

www.zaproxy.org/addons
