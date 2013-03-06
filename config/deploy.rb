set :application, "app1"
set :repository,  "git@github.com:teohm/sample-app1.git"
set :branch, "master"
set :keep_releases, 5


# Code Repository
# =========
set :scm, :git
set :scm_verbose, true
set :deploy_via, :remote_cache

# Remote Server
# =============
set :use_sudo, false
ssh_options[:forward_agent] = true

# Bundler
# -------
require 'bundler/capistrano'
set :bundle_without, [:test, :development, :deploy]

# Rbenv
# -----
default_run_options[:shell] = '/bin/bash --login'


# Rails: Asset Pipeline
# ---------------------
#load 'deploy/assets'

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts


# Server specific
# ----------------
set :user, "deploy"
server "testbox", :web, :app, :db, :primary => true
set :deploy_to, "/u/apps/#{application}"
set :rails_env, "production"


# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do
    run "#{try_sudo} sv up app1"
   end
   task :stop do
    run "#{try_sudo} sv down app1"
   end
   task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} sv restart app1"
   end
 end
