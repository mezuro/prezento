## Development

### System dependencies (Ubuntu 14.04 package names)
  - build-essential
  - postgresql-server-dev-9.3

### Unpacked dependecies
  - PhantomJS >= 1.9.2 (http://phantomjs.org/)
    - *NOTE:* Just create sym links for that, for example:

    ```bash
    cd /usr/local/share
    wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
    tar xjf phantomjs-1.9.7-linux-x86_64.tar.bz2
    sudo ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs
    sudo ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
    sudo ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/bin/phantomjs
    ```

### Ruby version

  `2.3.1`

  You can easily install it through the Ruby Version Manager - RVM. Instructions on how to do it can be found at http://rvm.io

  It is expected to work with:

  - 2.1.5 Debian 8
  - 2.0.0 CentOS 7

  *NOTE:* If you are using the gnome-shell, or any derivate like terminator, you have to mark on your profile the option to use a "login bash".


### Environment setup

- Gem installation:
  - `bundle install`

- Database creation:
  - `rake db:create`

- Database initialization (the seeds script will need the kalibro configurations service running):
  - `rake db:setup`

- Alternatively you can just run the setup script (it will also need the kalibro configurations service running):
  - `bin/setup`

### How to run the test suite

    rake

### Services (job queues, cache servers, search engines, etc.)

- _Kalibro Processor_ - [version 1.2.1](https://github.com/mezuro/kalibro_processor/archive/v1.2.1.zip).
  You can find the latest changes directly on the [repository](https://github.com/mezuro/kalibro_processor).
  By default Mezuro will expect it to be running on port 8082 at localhost.
  In order to run it as expected, run on two different terminal instances:

      RAILS_ENV=local rails s -p 8082
      RAILS_ENV=local rake jobs:work

- _Kalibro Configurations_ - [version 2.1.0](https://github.com/mezuro/kalibro_configurations/archive/v2.1.0.zip).
  You can find the latest changes directly on the [repository](https://github.com/mezuro/kalibro_configurations).
  By default Mezuro will expect it to be running on port 8083 at localhost.
  In order to run it as expected, run:

      rails s -p 8083

### Deployment instructions

  Deployment is made through Capistrano (https://github.com/capistrano/capistrano)

    cap production deploy

  In order to do this, you must have the password.

  Otherwise, you can also modify the deployment file at <tt>config/deploy.rb</tt>.

#### First Deploy

  1. Make sure that the deployment file <tt>config/deploy.rb</tt> is correctly configured to the installation server;
  2. Also, make sure that the installation server already has rvm installed;
  3. <tt>cap deploy:setup</tt> will install the ruby correct ruby version, the gemset and all the directories tree;
  4. <tt>cap deploy:migrations</tt> deploys the code and run all the migrations
