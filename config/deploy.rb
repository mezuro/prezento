require "rvm/capistrano"
require 'bundler/capistrano'

set :default_shell, "/bin/bash -l"
set :rails_env, "production"

set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"       # more info: rvm help autolibs
set :rvm_type, :system

set :application, "mezuro"
set :deploy_to, "/home/mezuro/app"
set :repository,  "https://github.com/mezuro/mezuro-standalone.git"

set :user, 'mezuro'
set :use_sudo, false

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "ec2-184-72-147-209.compute-1.amazonaws.com"                          # Your HTTP server, Apache/etc
role :app, "ec2-184-72-147-209.compute-1.amazonaws.com"                          # This may be the same as your `Web` server
role :db,  "ec2-184-72-147-209.compute-1.amazonaws.com", :primary => true # This is where Rails migrations will run

# before 'deploy:setup',          'rvm:install_rvm'        # install RVM
before 'deploy:setup',          'rvm:install_ruby'       # install Ruby and create gemset, OR:
before 'deploy:setup',          'rvm:create_gemset'      # only create gemset
after  'deploy:assets:symlink', 'deploy:config_symlinks'
after  'deploy:restart',        "deploy:cleanup"

namespace :deploy do
  task :start do ; end
  
  task :stop do ; end
  
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
   
  task :config_symlinks do
    run "ln -s #{File.join(deploy_to, 'shared', 'config/database.yml')} #{File.join(release_path, 'config/database.yml')}"
  end
end