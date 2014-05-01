source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby

# Use Modernizr for better browser compability
gem 'modernizr-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0.4'

# For user authentication and everything else
gem 'devise', '~> 3.2.4'

# Kalibro integration
gem 'kalibro_gatekeeper_client', "~> 0.1.0"

# PostgreSQL integration
gem "pg", "~> 0.17.0"

# Twitter Bootstrap for layout
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'

# Chart generation
gem "chart-js-rails", "~> 0.0.6"

# JQueryUI
gem 'jquery-ui-rails', '~> 4.2.1'

# colorpicker
gem 'colorpicker', '~> 0.0.5'

# Memcached
gem "dalli", "~> 2.7.0"

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', require: false

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', group: :development

group :test do
  # Easier test writing
  gem "shoulda-matchers", '~> 2.6.1'

  # Test coverage
  gem 'simplecov', require: false

  # Simple Mocks
  gem 'mocha', require: 'mocha/api'
end

group :development, :test do
  # Test framework
  gem 'rspec-rails'

  # Fixtures made easy
  gem 'factory_girl_rails', '~> 4.4.1'

  # Deployment
  gem 'capistrano', "~>3.1.0", require: false
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm', "~>0.1.0"

  # JavaScript unit tests
  gem "konacha", "~> 3.2.0"

  # Test coverage history
  gem 'coveralls', require: false

  # Better error interface
  gem 'better_errors'
  gem 'binding_of_caller'
end

# Acceptance tests
group :cucumber do
  gem 'cucumber-rails', '~> 1.4.0'
  gem 'database_cleaner'
  gem 'poltergeist', '~> 1.5.0'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use debugger
# gem 'debugger', group: [:development, :test]
