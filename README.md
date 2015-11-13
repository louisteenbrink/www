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

```
$ ALUMNI_BASE_URL=http://localhost:5000/api/v1 DISABLE_CACHE=true rails s
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

## Credits

The first commit of this app has been generated thanks to [lewagon/wagon_rails](https://github.com/lewagon/wagon_rails)'s rails app generator.
## Deploying

    $ bin/deploy
