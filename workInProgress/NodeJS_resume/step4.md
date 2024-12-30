# resume pdf



`resume export --format pdf --theme jsonresume-theme-modern  myresume.pdf`{{exec}}

WIP: having install with theme. First try theme with html, then pdf

check -https://www.npmjs.com/package/resume-cli
and -https://jsonresume.org/getting-started
also your devops pipeline

### In a new tab, with root user

taken from https://www.skynats.com/blog/install-google-chrome-headless-ubuntu-server/

`apt-get install libappindicator1 fonts-liberation`{{exec}}

`wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb`{{exec}}

`dpkg -i google-chrome-stable_current_amd64.deb`{{exec}}

`apt --fix-broken install`{{exec}}

`dpkg -i google-chrome-stable_current_amd64.deb`{{exec}}

`google-chrome-stable --version`{{exec}}

## return to tab for jsuser

`resume export --format pdf --theme jsonresume-theme-modern  myresume.pdf`{{exec}}
