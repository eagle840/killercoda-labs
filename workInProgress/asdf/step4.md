# Install Jekyll

https://jekyllrb.com/

https://www.youtube.com/playlist?list=PLLAZ4kZ9dFpOPV5C5Ay0pHaa0RJFhcmcB

https://github.com/cotes2020/jekyll-theme-chirpy

`cd ~`{{exec}}

`ruby -v`{{exec}}

`gem install bundler jekyll`{{exec}}

`jekyll new my-awesome-site`{{exec}}

`cd my-awesome-site`{{exec}}

`bundle exec jekyll -h`{{exec}}

`bundle exec jekyll serve  --host 0.0.0.0`{{exec}}

{{TRAFFIC_HOST1_4000}}

## Front Matter

Articles are in the _posts folder and have 'matter' at the top of the file.

```
title: Hello HomeLab
date: 2022-05-23 12:00:00 -500
categories: [homelab, hardware]
tags: [servers,dell, hp, supermicro] # TAG names should always be lowercase
```

The the project is built it will generate a static site in _site folder

---

## Use a Theme (Chirpy)

 `git clone https://github.com/cotes2020/jekyll-theme-chirpy.git`{{exec}}

`cd jekyll-theme-chirpy/`{{exec}}




`bundle install`{{exec}}

`bundle list`{{exec}}

`JEKYLL_ENV=production bundle exec jekyll b`{{exec}}

`bundle exec jekyll serve  --host 0.0.0.0`{{exec}}

{{TRAFFIC_HOST1_4000}}


## Host

Copy the _sites folder

be sure to checkout the github repo for more themes: https://github.com/topics/jekyll-theme