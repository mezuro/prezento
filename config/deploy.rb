require "rvm/capistrano"

set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"       # more info: rvm help autolibs
set :rvm_type, :system

#before 'deploy:setup', 'rvm:install_rvm'  # install RVM
#before 'deploy:setup', 'rvm:install_ruby' # install Ruby and create gemset, OR: # before 'deploy:setup', 'rvm:create_gemset' # only create gemset

set :application, "mezuro"
set :deploy_to, "/home/mezuro/app"
set :repository,  "https://github.com/mezuro/mezuro-standalone.git"

set :user, 'mezuro'
set :use_sudo, false

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "ec2-54-224-143-159.compute-1.amazonaws.com"                          # Your HTTP server, Apache/etc
role :app, "ec2-54-224-143-159.compute-1.amazonaws.com"                          # This may be the same as your `Web` server
role :db,  "ec2-54-224-143-159.compute-1.amazonaws.com", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
end