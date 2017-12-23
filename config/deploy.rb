require 'bundler/capistrano'
set :user, 'serj'
set :domain, 'shop.online.com'
set :application, "Shop"

set :rvm_type, :user
set :rvm_ruby_string, 'ruby-2.3.3'
require 'rvm/capistrano'

set :repository,  "#{user}@#{domain}:git/#{application}.git"
set :deploy_to, "/var/www/#{aplication}/public"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
set :rails_env, :production

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
	desc "cause Pessenger to initiate a restart"
	task :restart do
		run "touch #{current_path}/tmp/restart.txt"
	end
	desc "reload the database with seed data"
	task :seed do
		run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
	end
end
after "deploy:update_code", :bundle_install
desc "install the necessary prerequisites"
task :bundle_install, roles => :app do
	run "cd #{release_path} && bundle install"
end
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end