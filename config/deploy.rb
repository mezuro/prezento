set :application, 'mezuro'
set :repo_url, 'https://github.com/mezuro/mezuro.git'

set :branch, 'stable'

set :deploy_to, "/home/mezuro/app"
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

# User info
set :user, 'mezuro'

# RVM
set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"       # more info: rvm help autolibs
set :rvm_type, :system
set :rvm_install_with_sudo, true

namespace :deploy do
  after 'deploy:publishing', 'deploy:restart'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "touch #{File.join(current_path,'tmp','restart.txt')}"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  before :compile_assets, :config_symlinks do
    on roles(:web) do
      execute "ln -s #{File.join(deploy_to, 'shared', 'config/database.yml')} #{File.join(release_path, 'config/database.yml')}"
      execute "ln -s #{File.join(deploy_to, 'shared', 'config/kalibro.yml')} #{File.join(release_path, 'config/kalibro.yml')}"
    end
  end

  after :finishing, 'deploy:cleanup'

end
