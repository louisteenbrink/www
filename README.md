[![Build Status](https://travis-ci.org/lewagon/www.svg)](https://travis-ci.org/lewagon/www)
[![Stories in Ready](https://badge.waffle.io/lewagon/www.png?label=ready&title=Ready)](https://waffle.io/lewagon/www)

# Le Wagon

## Cache

You can run this in development to bypass the API cache.

```
$ DISABLE_CACHE=true rails s
```

## Configuration

The app configuration lies in `config/application.yml` and is **not**
versionned by git (for security reasons). If you've just cloned this
repo, ask a colleague for his `application.yml` file over a secure channel.

## Credits

The first commit of this app has been generated thanks to [lewagon/wagon_rails](https://github.com/lewagon/wagon_rails)'s rails app generator.
## Deploying

    $ bin/deploy
