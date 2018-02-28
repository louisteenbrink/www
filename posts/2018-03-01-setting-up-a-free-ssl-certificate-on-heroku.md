---
layout: post
title: "Setting up a free SSL certificate on Heroku"
author: sebastien
locale: "en"
labels:
  - tutorial
thumbnail: 2018-03-01-heroku-ssl.jpg
description: |
  Heroku now supports Let's Encrypt certificates and allow you to switch your application
  to https://. Caveat: you need to upgrade to a Hobby plan (7$/dyno/month).
---

In this tutorial, we will change the URL of your website from <code>http://www.yourdomain.tld</code> to <code>https://www.yourdomain.tld</code>. That's a subtle difference, but it is [very important](https://blog.hubspot.com/marketing/enable-https-on-your-website). We assume you already have a domain and it correctly points to your Heroku application. If that's not the case, check out [this tutorial](/blog/buying-a-domain-on-namecheap-and-pointing-it-to-heroku) first.

## Upgrading Dynos

Heroku now supports [Let's Encrypt](https://letsencrypt.org/), a free way of generating SSL certificates. They call it [Automated Certificate Management](https://devcenter.heroku.com/articles/automated-certificate-management) (or **ACM** in short).

Although the certificate is free, you still need to upgrade your application to _at least_ a Hobby plan to use it. Go to your Heroku dashboard, select your application and click on the **Resources** tab. You should quickly find the button **Upgrade to Hobby...**. Select the Hobby plan (7$/dyno/month) and Save.

![Heroku Switch to Hobby plan](blog_image_path 2018-03-01-01_upgrade_dynos.png)

## Configuring SSL

In Heroku, go back to the **Settings** tab of your application and scroll down to _Domain and certificates_. You should now see a white button **Configure SSL**. Click on it. Leave the **Automatically** option ticked and click on **Continue**.

![Configure SSL on Heroku](blog_image_path 2018-03-01-02_configure_ssl.png)

You should then have instructions to set up your DNS. That is something which we already did in the previous tutorial, so click on **I've done this** and **Continue**.

That's it! Open your favorite browser and navigate to <code>https://www.yourdomain.tld</code>, you should see a green URL bar with the **Secure** keyword 🍾

## Bonus - Forcing SSL in Rails

Right now, if you go to <code>http://www.yourdomain.tld</code>, your website is still served insecurly. You can't expect your visitors to manually add the missing <code>s</code> in the address bar. What you want to do is **force** a redirection from <code>http://</code> to <code>https://</code> URLs. In Rails, you can do that with a single line of code, using the <code>force_ssl</code> option.

To do so, go to your Rails project, open it in Sublime Text, and open the <code>config/environments/production.rb</code> file. Look for a commented line mentioning <code>force_ssl</code>. Update this line to have:

```ruby
config.force_ssl = true
```

That's the [exact same configuration](https://github.com/lewagon/www/blob/b1094499799d52ecc8c9f0f5ebd0dee9f49dceac/config/environments/production.rb#L77) we did on <code>www.lewagon.com</code>.

Commit & Push your changes to Heroku. You should now see an automatic redirection from <code>http://</code> URLs to <code>https://</code> (using a <code>301</code> and **preserving the path**).

Go ship something awesome! 🚀
