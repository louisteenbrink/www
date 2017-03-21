---
layout: post
title: "Social Meta Tags Setup in Rails"
author: edward
labels:
  - tuto
pushed: true
thumbnail: thumbnail-tuto-meta-tags.jpg
description: How to setup your social meta tags in Rails
---

Sharing your product on social networks has become one privileged way to grow your userbase. But before you unleash your sharing fury, make sure your social meta tags are properly set.

## WTF are meta tags?

`<meta>` tags are HTML tags in the `<head>` of a webpage, visible to anyone.

![Lewagon Demoday Metatags](blog_image_path lewagon_demoday_metatags.png)

They provide the contents displayed on social networks whenever your product's url is shared in a post.
Titles, descriptions and images should all be setup with care and consideration to improve your social exposure's conversion rate.
The right content, including optimized images have shown to help posts to spread, even leading to increased shares and mentions, improving natural SEO.

**For instance:**

<div class="embed-fb">
  <div id="fb-root"></div><script>(function(d, s, id) {  var js, fjs = d.getElementsByTagName(s)[0];  if (d.getElementById(id)) return;  js = d.createElement(s); js.id = id;  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.3";  fjs.parentNode.insertBefore(js, fjs);}(document, 'script', 'facebook-jssdk'));</script><div class="fb-post" data-href="https://www.facebook.com/lewagon/posts/589518731246729" data-width="500"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/lewagon/posts/589518731246729"></blockquote></div></div>
</div>


## Setup in a Rails app

In this tutorial, we'll see:

- how to simply setup default meta tags for any of your website's pages,
- how to override them in some views to be more specific and impactful.

##### **Default Meta Tags**

Let's create a `meta.yml` file in `config`, with the following:

```
# config/meta.yml

meta_title: "Product name"
meta_description: "Product tagline"
meta_image: "cover.png" # should exist in `app/assets/images/`
twitter_account: "@product_twitter_account" # required for Twitter Cards
```

Let's create a `default_meta.rb` file in `config/initializers` in which we load the content as a Hash in a `DEFAULT_META` Ruby constant.

```
# config/initializers/default_meta.rb

# Initialize default meta tags.
DEFAULT_META = YAML.load_file(Rails.root.join('config/meta.yml'))
```
**Important: as any file in the** `config/initializers` **folder, it is loaded when your app is launched. Any time you change its content, restart your** `rails s` **to refresh your data!**

##### **Helpers setup**
Now before setting up our meta tags in our views, let's setup helpers that will encapsulate the following logic for our 3 keys `:meta_title`, `:meta_description` and `:meta_image`:


> In any view, if a `content_for(:meta_key)` was defined, it should override the default value in `DEFAULT_META`.

Let's create a new `app/helpers/meta_tags_helper.rb` file with the following:

```
module MetaTagsHelper
  def meta_title
    content_for?(:meta_title) ? content_for(:meta_title) : DEFAULT_META['meta_title']
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) : DEFAULT_META['meta_description']
  end

  def meta_image
    meta_image = (content_for?(:meta_image) ? content_for(:meta_image) : DEFAULT_META['meta_image'])
    # little twist to make it work equally with an asset or a url
    meta_image.starts_with?("http") ? meta_image : image_url(meta_image)
  end
end
```

##### **Important: production host setup for images absolute urls**

Rails `image_url` helper requires you setup your host to generate the **absolute url** needed to load your images from the external world (Facebook, Twitter, ...).

Let's override `Rails.application.default_url_options[:host]` by adding the following in `app/controllers/application_controller.rb`:

```
# app/controllers/application_controller.rb

def default_url_options
  { host: ENV["HOST"] || "localhost:3000" }
end
```

Make sure your production `HOST` variable is set with your domain name.
If you deploy your code with Heroku for instance, just type in your terminal `heroku config:set HOST=www.my_product.com`

You can check it's properly set with `heroku config:get HOST`.

##### **HTML setup**

Finally, open your layout `app/views/layouts/application.html.erb` and copy paste the following meta tags in your layout's `<head>`:

```
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

<!-- Google+ Schema.org markup -->
<meta itemprop="name" content="<%= meta_title %>">
<meta itemprop="description" content="<%= meta_description %>">
<meta itemprop="image" content="<%= meta_image %>">
```

Now let's assume you have an `Offer` model and you want dynamic titles and descriptions for any `products#show` page.
Just set the relevant `content_for`s in `app/views/offers/show.html.erb`:

```
<!-- app/views/products/show.html.erb -->
<% content_for :meta_title, "#{@offer.name} is on #{DEFAULT_META["title"]}" %>
<% content_for :meta_description, @offer.description %>
<% content_for :meta_description, cloudinary_url(@offer.photo.path) %>
```

