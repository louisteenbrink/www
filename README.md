[![Build Status](https://travis-ci.org/lewagon/www.svg)](https://travis-ci.org/lewagon/www)
[![Stories in Ready](https://badge.waffle.io/lewagon/www.png?label=ready&title=Ready)](https://waffle.io/lewagon/www)

# Le Wagon

## Cache

You can run this in development to bypass the API cache.

```
$ DISABLE_CACHE=true rails s
```

## API

You can work with development API by launching a `rails s -p 5000` of [lewagon/alumni](https://github.com/lewagon/alumni) in another terminal tab, then launch the `www` rails app with:

```bash
ALUMNI_BASE_URL=http://localhost:5000/api/v1 DISABLE_CACHE=true rails s
```

## How to add a new city

- Create a new City in production at [alumni.lewagon.org/admin](http://alumni.lewagon.org/admin)
- Create a branch in the `www` repo.
- Locally add a new slug to [data/cities.yml](data/cities.yml)
- Go to `http://localhost:3000/the_new_city_slug`
- Change production data on Alumni admin until you're satisfied
- Commit and push your changes


## Configuration

The app configuration lies in `config/application.yml` and is **not**
versionned by git (for security reasons). If you've just cloned this
repo, ask a colleague for his `application.yml` file over a secure channel.

### Linkedin Token

The token lasts 2 months. To generate it, launch a `rails c` locally then:

```ruby
oauth = LinkedIn::OAuth2.new; puts oauth.auth_code_url # Go to this URL
code = "WHAT YOU GOT FROM THE URL"
l_token = oauth.get_access_token(code); puts l_token.token
puts "will expire on #{Date.strptime(l_token.expires_at.to_s, '%s')}. You may want to add this date to the calendar"
```
