source "https://rubygems.org"
ruby File.read(".ruby-version").strip

gem "rails", "5.0.0.1"
gem 'responders', '~> 2.0'
gem "pg"
gem "figaro"
gem "simple_form"
gem "rest-client"
gem 'meetup_client'
gem "redis"
gem 'redis-rails'
gem 'devise'
gem "omniauth-github"

gem "jquery-rails"
gem "sass-rails", "~> 5.0"
gem "uglifier"
gem "email_validator"
gem "rails-i18n"
gem 'pygmentize'
gem 'redcarpet'
gem "bootstrap-sass"
gem "font-awesome-sass"
gem "react-rails"
gem 'react-bootstrap-rails'
gem "lodash-rails"
gem 'js-routes'
gem 'autoprefixer-rails'
gem "jquery-slick-rails"
gem 'money-rails'
gem 'gibbon'
gem 'ruby-trello'
gem 'raygun4ruby'
gem 'sitemap_generator'
gem 'builder'
gem 'rack-utf8_sanitizer'
gem 'cloudinary'

gem 'critical-path-css-rails', git: 'https://github.com/mudbugmedia/critical-path-css-rails.git'

source "https://rails-assets.org" do
  gem 'rails-assets-mdi'
  gem 'rails-assets-classnames'
  gem 'rails-assets-pubsub-js'
  gem 'rails-assets-devicons'
  gem 'rails-assets-headroom.js'
end

group :development, :test do
  gem "spring"
  gem "letter_opener"

  gem "rspec-rails"
end

group :development do
  gem "pry-byebug"
  gem "pry-rails"
  gem "annotate"
  gem "binding_of_caller"
  gem "better_errors"
  gem 'rack-mini-profiler'
end

group :test do
  gem "capybara"
end

group :production do
  gem "rails_12factor"
  gem "puma"
end
