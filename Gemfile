source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# For user authentication and everything else
gem 'devise', '~> 3.5.1'

# Kalibro integration
gem 'kalibro_client', '~> 4.0'

# PostgreSQL integration
gem "pg", "~> 0.18.1"

# Twitter Bootstrap for layout
gem 'less-rails', '~> 2.7.0'
gem 'railsstrap', '~> 3.3.4'

# Chart generation
gem "chart-js-rails", "~> 0.0.6"

# JQueryUI
gem 'jquery-ui-rails', '~> 5.0.0'

# colorpicker
gem 'colorpicker', '~> 0.0.5'

# Memcached
gem "dalli", "~> 2.7.0"

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Rails Html Sanitizer for HTML sanitization
gem 'rails-html-sanitizer', '~> 1.0'

# Sends a email whenever there is a unexpected exception
gem 'exception_notification', '~> 4.1.1'

# Google Analytics
gem 'google-analytics-rails', '~> 0.0.6'

# Browser language detection
gem 'http_accept_language'

# Routes for JS files
gem 'js-routes', '~> 1.1.0'

group :test do
  # Easier test writing
  gem "shoulda-matchers", '~> 2.8.0'

  # Test coverage
  gem 'simplecov', require: false

  # Simple Mocks
  gem 'mocha', require: 'mocha/api'

  # Test coverage report
  gem 'codeclimate-test-reporter', require: nil

  # For Konacha
  gem 'thin'
end

# Startup script generation (server process manager)
gem 'foreman', '~>0.78.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Test framework
  gem 'rspec-rails', '~> 3.3.2'

  # Fixtures made easy
  gem 'factory_girl_rails', '~> 4.5.0'

  # Deployment
  gem 'capistrano', "~>3.4.0", require: false
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm', "~>0.1.0"

  # JavaScript unit tests
  gem "konacha"

  # Better error interface
  gem 'better_errors'
  gem 'binding_of_caller'

  # Localization assistance
  gem 'i18n_generators'

  gem 'sprockets'

  # Mocks and stubs for javascript tests
  gem 'sinon-rails'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Automatized gem update
  gem 'gisdatigo'

  # Slice tests across jobs on CI
  gem 'knapsack'

  # JavaScript server
  gem 'poltergeist', '~> 1.7.0'
end

# Acceptance tests
group :cucumber do
  gem 'cucumber-rails', '~> 1.4.0'
  # cleans the database
  gem 'database_cleaner', '~> 1.5.0'
end


# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'
