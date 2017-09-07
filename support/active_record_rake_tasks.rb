require 'yaml'
require 'active_record'
require 'erb'
include ActiveRecord::Tasks

root = File.expand_path('../..', __FILE__)
DatabaseTasks.env = ENV['ENV'] || 'development'
DatabaseTasks.database_configuration = YAML.load(ERB.new(IO.read(File.join(root, 'config/database.yml'))).result)
DatabaseTasks.migrations_paths = [File.join(root, 'db/migrate')] #Not actually used, just needs to be set
DatabaseTasks.db_dir = File.join(root, 'spec', 'support')
DatabaseTasks.root = root

task :environment do
  ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
  ActiveRecord::Base.establish_connection(DatabaseTasks.env.to_sym)
end

load 'active_record/railties/databases.rake'