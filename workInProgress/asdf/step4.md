# Install Jekyll

Jekyll is a static site generator built using Ruby. It is a popular tool used to create simple, static websites or blogs without the need for a backend server or a database. Jekyll takes content written in Markdown, HTML, or other formats and generates a static website that can be hosted on any web server.

Some key features of Jekyll include:

1. **Markdown Support**: Jekyll allows you to write content in Markdown, a lightweight markup language, making it easy to create and format content without needing to write HTML.

2. **Liquid Templating**: Jekyll uses the Liquid templating language to create reusable templates for your site. This allows you to define layouts, include partials, and use variables in your site's design.

3. **Front Matter**: Jekyll supports front matter, which is metadata at the beginning of a file that can be used to define variables, such as layout, title, or other custom data.

4. **Plugins**: Jekyll has a plugin system that allows you to extend its functionality with additional features or customizations.

5. **GitHub Pages Integration**: Jekyll is the engine behind GitHub Pages, a free hosting service provided by GitHub. You can easily deploy Jekyll sites to GitHub Pages for free hosting.

Overall, Jekyll is a versatile and easy-to-use tool for creating static websites or blogs, making it a popular choice for developers, bloggers, and content creators who want a simple and lightweight solution for their websites.

https://jekyllrb.com/

https://www.youtube.com/playlist?list=PLLAZ4kZ9dFpOPV5C5Ay0pHaa0RJFhcmcB

https://github.com/cotes2020/jekyll-theme-chirpy

## Start a basic Jekyll site

`cd ~`{{exec}}

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

`cd ~`{{exec}}

 `git clone https://github.com/cotes2020/jekyll-theme-chirpy.git`{{exec}}

`cd jekyll-theme-chirpy/`{{exec}}

`bundle install`{{exec}}

`bundle list`{{exec}}

`JEKYLL_ENV=production bundle exec jekyll b`{{exec}}

`bundle exec jekyll serve  --host 0.0.0.0`{{exec}}

{{TRAFFIC_HOST1_4000}}

### Just the Docs

https://github.com/just-the-docs/just-the-docs

`gem install just-the-docs`{{exec}}


## Host

Copy the _sites folder

be sure to checkout the github repo for more themes: https://github.com/topics/jekyll-theme