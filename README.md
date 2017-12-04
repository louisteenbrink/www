[![Build Status](https://travis-ci.org/lewagon/www.svg)](https://travis-ci.org/lewagon/www)

# Le Wagon

## Dependencies

You need Postgresql and Redis running on your computer. You also need [ImageMagick](http://brewformulas.org/Imagemagick)

## Setup

After cloning the project, run:

```bash
bundle install
bin/rails db:create db:schema:load
```

Then ask for the ENV variables below before starting your `bin/rails s` server.

## Configuration

The app configuration lies in `config/application.yml` and is **not**
versionned by git (for security reasons). If you've just cloned this
repo, ask a colleague for his `application.yml` file over a secure channel.

The bare minimum variables you need to start the website are:

```yml
# config/application.yml
KITT_WWW_SHARED_SECRET: "ask_for_it"
CLOUDINARY_URL: "ask_for_it"
```

## Create a new post

To create a new blog post file, you run this command:

```bash
rails post:create
```

## Cache

You can run this in development to bypass the API cache.

```
$ DISABLE_CACHE=true rails s
```

## API Development

You can work with development API by launching a `rails s -p 5000` of [lewagon/kitt](https://github.com/lewagon/kitt) in another terminal tab, then launch the `www` rails app with:

```bash
KITT_BASE_URL=http://localhost:5000 DISABLE_CACHE=true rails s
```

### Linkedin Token

The token lasts 2 months. To generate it, launch a `rails c` locally then:

```ruby
oauth = LinkedIn::OAuth2.new; puts oauth.auth_code_url # Go to this URL
code = "WHAT YOU GOT FROM THE URL"
l_token = oauth.get_access_token(code); puts l_token.token
puts "will expire on #{Date.strptime(l_token.expires_at.to_s, '%s')}. You may want to add this date to the calendar"
```
