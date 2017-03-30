---
layout: post
title: "Le setup des Meta Tags dans Rails"
author: cedric
labels:
  - tuto
pushed: true
thumbnail: thumbnail-tuto-meta-tags.jpg
description: Éléments indispensables pour obtenir un aperçu qualitatif de vos contenus sur les réseaux sociaux, nous vous proposons ce tutoriel pour suivre pas à pas le setup des Meta Tags dans une application Rails.
---

Éléments indispensables pour obtenir un aperçu qualitatif de vos contenus sur les réseaux sociaux, nous vous proposons ce tutoriel pour suivre pas à pas le setup des Meta Tags dans une application Rails.

## Meta Tags, mais de quoi parle-t-on ?

Les Meta Tags sont présents dans le `<head>` de vos pages et peuvent être consultables sur n'importe quel site web.

![Lewagon Demoday Metatags](blog_image_path lewagon_demoday_metatags.png)

Les Meta Tags fournissent les informations affichées dans l'aperçu de vos contenus sur les réseaux sociaux. Les titres, descriptions et images associés sont autant d'éléments à choyer et à considérer avec attention afin de susciter l'intérêt de vos futurs visiteurs / clients via vos posts Facebook, Tweet et Pinterest Rich Pins.

**Exemple :**

<div class="embed-fb">
  <div id="fb-root"></div><script>(function(d, s, id) {  var js, fjs = d.getElementsByTagName(s)[0];  if (d.getElementById(id)) return;  js = d.createElement(s); js.id = id;  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.3";  fjs.parentNode.insertBefore(js, fjs);}(document, 'script', 'facebook-jssdk'));</script><div class="fb-post" data-href="https://www.facebook.com/lewagon/posts/589518731246729" data-width="500"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/lewagon/posts/589518731246729"></blockquote></div></div>
</div>

<hr>

## Le setup dans Rails

L'idée de ce tutoriel est de vous montrer comment obtenir ce résultat sur chacune des vues de votre site. Nous allons donc commencer par configurer des Meta Tags par défaut avant de définir des helpers qui vous permettront de les customiser sur les vues de votre choix. Enfin nous jetterons un oeil sur le markup HTML nécessaire et les outils de débogage à votre disposition.

<hr>

##### **Créez des Meta Tags par défaut**

Commencez par créer un nouveau fichier `meta.yml` dans `config`, avec le contenu suivant :

```yaml
# config/meta.yml
meta_title: "Nom du Product - Tagline du Product"
meta_description: "Description percutante"
meta_image: "image.jpg" # Une image dans votre dossier app/assets/images/
twitter_account: "@nomdevotrecompte" # indispensable pour les Twitter Cards
```

Créez ensuite un fichier `default_meta.rb` dans `config/initializers` où le `yaml` sera chargé dans une constante Ruby `DEFAULT_META` :

```ruby
# config/initializers/default_meta.rb

# Initialize default meta tags.
DEFAULT_META = YAML.load_file(Rails.root.join("config/meta.yml"))
```

**Important: comme tout fichier dans le dossier** `config/initializers` **, ce dernier est chargé au démarrage de l'app. Dès que vous changez le contenu du** `meta.yml`**, relancez votre** `rails s` **pour mettre à jour** `DEFAULT_META`**!**

<hr>

##### **Helpers**

Dans un nouveau helper `app/helpers/meta_tags_helper.rb` définissez les méthodes suivantes afin de pouvoir créer des Meta Tags spécifiques à vos vues/contenus :

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
    # ajoutez la ligne ci-dessous pour que le helper fonctionne indifféremment
    # avec une image dans vos assets ou une url absolue
    meta_image.starts_with?("http") ? meta_image : image_url(meta_image)
  end
end
```

##### **Important: la gestion des urls de vos images**

Par défaut, Rails retourne le chemin **relatif** de vos URLs (routing helpers suffixés en `_path`). Il est donc primordial de lui dire de retourner les urls absolues afin que celles-ci puissent être récupérées par Facebook et Twitter. Pour ce faire, placez le snippet ci-dessous dans votre `application_controller.rb`.

```ruby
# app/controllers/application_controller.rb

def default_url_options
  { host: ENV['HOST'] || 'localhost:3000' }
end
```

Assurez-vous de bien avoir défini la variable d'environnement `HOST` en **production**.
Si vous utilisez Heroku pour déployer votre site, il suffit de taper dans votre terminal `heroku config:set HOST=www.my_product.com` avec l'url de votre site web.

Pour vérifier qu'elle est bien définie, tapez `heroku config:get HOST` à la ligne de commande et elle devrait s'afficher.

<hr>

##### **Le markup HTML - Layout**

Rendez-vous ensuite dans `app/views/layouts/application.html.erb` et copiez/collez les Meta Tags suivants dans le `head` de votre application :

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
##### **Le markup HTML - Vues**

Supposons que vous ayez un modèle `Offer` et vous souhaitez des meta tags dynamiques dans chacune des vues `show` correspondantes.
Vous n'avez plus qu'à définir les `content_for` pertinents dans `app/views/offers/show.html.erb` :

```erb
<!-- app/views/offers/show.html.erb -->

<% content_for :meta_title, "#{@offer.name} est sur #{DEFAULT_META["meta_title"]}" %>
<% content_for :meta_description, @offer.description %>
<% content_for :meta_image, cloudinary_url(@offer.photo.path) %>
```

##### **Déployez et testez**

Il est temps de déployer votre code pour tester votre nouvelle configuration !

Les réseaux sociaux fournissent des outils de debug en ligne vous permettant de prévisualisez les cards ainsi générées :

- [Facebook Debug Tool](https://developers.facebook.com/tools/debug/)
- [Twitter Card Validator](https://cards-dev.twitter.com/validator)

**Important :** Open Graph recommande des dimensions de **1200x630** pour les meta images. [Parcourez les best-practices](https://developers.facebook.com/docs/sharing/best-practices) afin d'éliminer tous les avertissements de l'outil de debug !

<hr>

##### **That's all folks**
Ce tutoriel s'achève déjà ! Mais rappelez-vous bien que nous n'avons défini là qu'une **base de travail** pour avoir de bons meta tags sur **toutes les pages** de votre site.
A vous de continuer de définir des **titres**, **descriptions** et **photos** percutantes pour **toutes** les nouvelles pages de votre site — **au fur et à mesure que vous les codez** — afin d'avoir la même crédibilité que les grands acteurs de la scène Tech !

![Airbnb Metatags](blog_image_path airbnb_meta_tags.png)

