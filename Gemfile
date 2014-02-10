source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

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
gem 'jbuilder', '~> 2.0.2'

# For user authentication and everything else
gem 'devise', '~> 3.2.0'

# Kalibro integration
gem 'kalibro_gem', "~> 0.0.1.rc17"

# PostgreSQL integration
gem "pg", "~> 0.17.0"

# Twitter Bootstrap for layout
gem "twitter-bootstrap-rails", "~> 2.2.8"

# Chart generation
gem "chart-js-rails", "~> 0.0.6"

# JQueryUI
gem 'jquery-ui-rails', '~> 4.1.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test do
  # Easier test writing
  gem "shoulda-matchers"

  # Test coverage
  gem 'simplecov', :require => false

  # Simple Mocks
  gem 'mocha', :require => 'mocha/api'
end

group :development, :test do
  # Test framework
  gem 'rspec-rails'

  # Fixtures made easy
  gem 'factory_girl_rails', '~> 4.3.0'

  # Deployment
  gem 'capistrano', "~>3.0.1", require: false
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm', "~>0.1.0"

  # JavaScript unit tests
  gem "konacha", "~> 3.0.0"

  # Test coverage history
  gem 'coveralls', require: false

  # Better error interface
  gem 'better_errors'
  gem 'binding_of_caller'
end

# Acceptance tests
group :cucumber do
  gem 'cucumber-rails', '~> 1.4.0'
  #Fixed the cumcumber version since the version 1.3.4 causes tests failure
  gem 'cucumber', '~> 1.3.10'
  gem 'database_cleaner'
  gem 'poltergeist', '~> 1.5.0'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
