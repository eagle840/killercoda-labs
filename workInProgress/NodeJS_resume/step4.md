# resume pdf

With the following, we get an error

`resume export --format pdf --theme jsonresume-theme-flat  myresumeflat.pdf`{{exec}}

Lets fix that:

### In a new tab, with root user

taken from https://www.skynats.com/blog/install-google-chrome-headless-ubuntu-server/

`apt-get install libappindicator1 fonts-liberation`{{exec}}

`wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb`{{exec}}

`dpkg -i google-chrome-stable_current_amd64.deb`{{exec}}

`apt --fix-broken install`{{exec}}

`dpkg -i google-chrome-stable_current_amd64.deb`{{exec}}

`google-chrome-stable --version`{{exec}}

### Run again (in the jsuser tab)


`resume export --format pdf --theme jsonresume-theme-flat  myresumeflat.pdf`{{exec}}

`ls`{{exec}}

## View in the web server

`http-server -c-1 -a 0.0.0.0`{{exec}}

{{TRAFFIC_HOST1_8080}}
