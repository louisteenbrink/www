---
layout: post
title: "Social Meta Tags Setup in Rails"
author: edward
locale: "en"
labels:
  - tutorial
thumbnail: 22-03-2017-rails-social-metatags.jpg
description: Sharing your product on social networks has become one privileged way to grow your userbase. But before you unleash your sharing fury, make sure your social meta tags are properly set.
---

Sharing your product on **social networks** has become one privileged way to grow your userbase. But before you unleash your sharing fury, make sure your **social meta tags** are properly set.

## WTF are meta tags?

`<meta>` tags are HTML tags in the `<head>` of a webpage, visible to anyone.

![Lewagon Demoday Metatags](blog_image_path 22-03-2017-rails-social-metatags.jpg)

They provide the **content displayed on social networks** whenever your product's url is **shared in a post**.
Titles, descriptions and images should all be setup with care and consideration to **improve your social exposure's conversion rate**.
The right content, including optimized images have shown to help posts to spread, even leading to increased shares and mentions, **improving natural SEO**.

**For instance:**

<div class="embed-fb">
  <div id="fb-root"></div><script>(function(d, s, id) {  var js, fjs = d.getElementsByTagName(s)[0];  if (d.getElementById(id)) return;  js = d.createElement(s); js.id = id;  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.3";  fjs.parentNode.insertBefore(js, fjs);}(document, 'script', 'facebook-jssdk'));</script><div class="fb-post" data-href="https://www.facebook.com/lewagon/posts/589518731246729" data-width="500"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/lewagon/posts/589518731246729"></blockquote></div></div>
</div>

## Setup in a Rails app

In this tutorial, we'll see:

- how to simply setup **default** meta tags for **any** of your website's pages,
- how to override them in **some pages** to be more specific and impactful.

## Default Meta Tags

Let's create a `meta.yml` file in `config`, with the following:

```yaml
# config/meta.yml

meta_product_name: "Product Name"
meta_title: "Product name - Product tagline"
meta_description: "Relevant description"
meta_image: "cover.png"                       # should exist in `app/assets/images/`
twitter_account: "@product_twitter_account"   # required for Twitter Cards
```

Let's create a `default_meta.rb` file in `config/initializers` in which we load the content as a Hash in a `DEFAULT_META` Ruby constant.

```
# config/initializers/default_meta.rb

# Initialize default meta tags.
DEFAULT_META = YAML.load_file(Rails.root.join("config/meta.yml"))
```

**Important: as any file in the** `config/initializers` **folder, it is loaded when your app is launched. Any time you change the content in** `meta.yml`**, restart your** `rails s` **to refresh** `DEFAULT_META`**!**

## Helpers setup

Now before setting up our meta tags in our views, let's setup **helpers** that will encapsulate the following logic for our 3 keys `:meta_title`, `:meta_description` and `:meta_image`:

__In any view, if a__ `content_for(:meta_key)` __was defined, it should override__ `DEFAULT_META`__'s value.__

Let's create a new `app/helpers/meta_tags_helper.rb` file with the following:

```ruby
# app/helpers/meta_tags_helper.rb

module MetaTagsHelper
  def meta_title
    content_for?(:meta_title) ? content_for(:meta_title) : DEFAULT_META["meta_title"]
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) : DEFAULT_META["meta_description"]
  end

  def meta_image
    meta_image = (content_for?(:meta_image) ? content_for(:meta_image) : DEFAULT_META["meta_image"])
    # little twist to make it work equally with an asset or a url
    meta_image.starts_with?("http") ? meta_image : image_url(meta_image)
  end
end
```

## Important: production host setup for images absolute urls

Rails `image_url` helper requires you setup your host to generate the **absolute url** needed to load your images from the **external world** (Facebook, Twitter, ...).

Let's override `Rails.application.default_url_options[:host]` by adding the following in `app/controllers/application_controller.rb`:

```ruby
# app/controllers/application_controller.rb

def default_url_options
  { host: ENV["HOST"] || "localhost:3000" }
end
```

Make sure your **production** `HOST` **variable** is set with your domain name.
If you deploy your code with Heroku for instance, just type in your terminal `heroku config:set HOST=www.my_product.com`

You can check it's properly set with `heroku config:get HOST`.

## HTML setup - Layout

Finally, open your layout `app/views/layouts/application.html.erb` and copy paste the following meta tags in your layout's `<head>`:

```erb
<title><%= meta_title %></title>
<meta name="description" content="<%= meta_description %>">

<!-- Facebook Open Graph data -->
<meta property="og:title" content="<%= meta_title %>" />
<meta property="og:type" content="website" />
<meta property="og:url" content="<%= request.original_url %>" />
<meta property="og:image" content="<%= meta_image %>" />
<meta property="og:description" content="<%= meta_description %>" />
<meta property="og:site_name" content="<%= meta_title %>" />

<!-- Twitter Card data -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:site" content="<%= DEFAULT_META["twitter_account"] %>">
<meta name="twitter:title" content="<%= meta_title %>">
<meta name="twitter:description" content="<%= meta_description %>">
<meta name="twitter:creator" content="<%= DEFAULT_META["twitter_account"] %>">
<meta name="twitter:image:src" content="<%= meta_image %>">
```

## HTML setup - Views

Now let's assume you have an `Offer` model and you want dynamic titles and descriptions for any `products#show` page.
Just set the relevant `content_for`s in `app/views/offers/show.html.erb`:

```erb
<!-- app/views/offers/show.html.erb -->
<% content_for :meta_title, "#{@offer.name} is on #{DEFAULT_META["meta_product_name"]}" %>
<% content_for :meta_description, @offer.description %>
<% content_for :meta_image, cl_image_path(@offer.photo.path) %>
```

## Testing

It's time to **deploy** your code and test your setup.

Social Networks provide **debugging tools** to help you check your tags are properly set.

- [Facebook Debug Tool](https://developers.facebook.com/tools/debug/)
- [Twitter Card Validator](https://cards-dev.twitter.com/validator)

**Important :** Facebook's Open Graph recommends **1200x630** dimensions for meta images. [Read the documentation](https://developers.facebook.com/docs/sharing/best-practices) if you cannot manage to clear out all their warnings!

## That's all folks
This sets a **framework** to easily manage your meta tags in **every single page** of your website.
It's now up to you to keep on setting relevant titles, descriptions and images **every time you code a new view**!

![Airbnb Metatags](blog_image_path 22-03-2017-airbnb-meta-tags.jpg)

