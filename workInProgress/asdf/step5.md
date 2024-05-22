# Install Jekyll

https://jekyllrb.com/

https://www.youtube.com/playlist?list=PLLAZ4kZ9dFpOPV5C5Ay0pHaa0RJFhcmcB

https://github.com/cotes2020/jekyll-theme-chirpy

`cd ~`{{exec}}

`ruby -v`{{exec}}

`gem install bundler jekyll`{{exec}}

`jekyll new my-awesome-site`{{exec}}

`cd my-awesome-site`{{exec}}

`bundle exec jekyll serve  --host 0.0.0.0`{{exec}}

---

 `git clone https://github.com/cotes2020/jekyll-theme-chirpy.git`{{exec}}

`cd jekyll-theme-chirpy/`{{exec}}


`bundle install`{{exec}}

`JEKYLL_ENV=production bundle exec jekyll b`{{exec}}

`bundle exec jekyll serve  --host 0.0.0.0`{{exec}}

   ## matter

```
title: Hello HomeLab
date: 2022-05-23 12:00:00 -500
categories: [homelab, hardware]
tags: [servers,dell, hp, supermicro] # TAG names should always be lowercase
```

# Host

Copy the _sites folder