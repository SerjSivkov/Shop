namespace :db do
	desc "Эта задача выводит примененные версии миграции"
	task :schema_migrations => :environment do
		puts ActiveRecord::Base.connection.select_values('select vaersion from schema_migrations order by version')
	end
end