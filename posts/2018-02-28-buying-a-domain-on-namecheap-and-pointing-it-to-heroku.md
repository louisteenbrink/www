---
layout: post
title: "Buying a domain on Namecheap and pointing it to Heroku"
author: sebastien
locale: "en"
labels:
  - tutorial
thumbnail: 2018-02-28-heroku-namecheap.jpg
description: |
  This tutorial shows how to buy a domain on Namecheap and point a subdomain to a Heroku application. Bonus: configure an email redirection.
---

In this tutorial, we will walk through the necessary steps to buy a domain on **Namecheap** and configure the `www` subdomain to point to an _existing_ **Heroku** application.

![rails new & heroku create](blog_image_path 2018-02-28-01_rails_new_push_heroku.png)

## Buying the domain

Sign up to [Namecheap](https://www.namecheap.com/myaccount/signup.aspx) with a username, email and password. Then [search](https://www.namecheap.com/domains/domain-name-search.aspx) for an available domain. A domain is a name + a [TLD](https://en.wikipedia.org/wiki/Top-level_domain), no need to type `www` (that would be a **sub**-domain).

I am buying the domaine <code>awesome-domain.fun</code>. You can ignore all the upsell items under "Improve Your Site" and click on "Confirm Order":

![Search for Namecheap domain](blog_image_path 2018-02-28-02_namecheap_confirm_order.png)

You will have a few screens where you need to specify your identity (and your company's if you're buying it on behalf of your venture) until you get to the Payment page. You can choose between a credit card and Paypal. You are buying a domain for a **specific amount of time** (usually one year), which means that after a year you will have to pay again if you want to keep it. In my scenario, I am paying $0.88 now but if I want to renew it I will have to pay $19.88 next year.

![Namecheap Order recap](blog_image_path 2018-02-28-03_namecheap_order_recap.png)

Yu can now click on "Manage" to go to the Domain List admin section.

## Pointing the domain to Heroku

The goal is now to point the `www` subdomain to my previously created Heroku application. This is a 2-step process.

First connect to the Heroku dashboard, select the heroku application and go to the "Settings" tab. Scroll down until you reach the **Domain and certificates** section. Click on the purple "Add domain" button and type the domain name **with its subdomain** you want to use. Here I am going to type <code>www.awesome-domain.fun</code>.

💡 Do not use a domain _without_ a subdomain (called bare, naked, root or apex), as it brings [limitations](https://devcenter.heroku.com/articles/apex-domains). Always use a subdomain.

![Add a domain on Heroku](blog_image_path 2018-02-28-04_add_domain_on_heroku.png)

You should now get the <code>CNAME</code> on Heroku, it should look like <code>yourdomain.herokudns.com</code>. Copy it, we will need it in Namecheap.

![CNAME on heroku](blog_image_path 2018-02-28-05_heroku_cname.png)

Go back to Namecheap Domain List, click on your domain to manage it. Then go to the **Advanced DNS** tab. You will find that the <code>www</code> subdomain (what Namecheap has under the column **Host**) is already assigned to a _parking page_. We need to **edit** this record. Click in the **Value** column to edit and paste what you copied in Heroku. Add a final dot <code>.</code> at the end. Then click on the little green tick icon to confirm.


![CNAME on heroku](blog_image_path 2018-02-28-06_configure_cname_in_namecheap.png)

That should be it! To check if this change has propagated to your local DNS server, you can use the `dig` command with:

<pre>
dig CNAME yourdomain.tld
</pre>

![dig CNAME www.awesome-domain.fun](blog_image_path 2018-02-28-07_dig.png)

You can see in the screenshot above that <code>www.awesome-domain.fun</code> is pointing with a <code>CNAME</code> to <code>www.awesome-domain.fun.herokudns.com</code>. We are all good! You can open your favorite browser and go to <code>http://yourdomain.tld</code> to check the result 👏

## Bonus - Redirect an email address

It may be useful to have an email like <code>contact@yourdomain.tld</code>. With Namecheap, you can set up an email redirection to go straight to your personal inbox.

Go to the **Domain** tab, and scroll down until you reach the **Redirect Email** section. Click on the _Add Forwarder_ button, specify the forwarder (without the <code>@yourdomain.tld</code>) and your personal email. Confirm by clicking on the green tick icon.

![Redirect contact@ to your personal email](blog_image_path 2018-02-28-08_email_forwarder.png)

That's it! Ask someone on your team to send an email to <code>contact@yourdomain.tld</code>:

![Testing redirection](blog_image_path 2018-02-28-09_testing_email_forwarder.png)

You should receive it instantaneously 🍾.
