set :application, 'doc-manager'
set :repo_url, 'git://github.com/ElizabethWilson/doc-manager.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/var/www/my_app'
set :deploy_to, "/u/apps/doc-manager"
set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{log}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }
set :rails_env, :productions
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute "rm -rf /u/apps/doc-manager/current/tmp/* && kill -s USR2 `cat /tmp/unicorn.doc-manager.pid`"
    end
  end

  desc 'start unicorn'
  task :start do
    on roles(:app) do
      execute "cd #{release_path}/ ; RAILS_ENV=production bundle exec unicorn_rails -c config/unicorn.rb -D -E production"
    end
  end

  after :finishing, 'deploy:cleanup'

end
