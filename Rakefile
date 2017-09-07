require "bundler/gem_tasks"
# require "rspec/core/rake_task"

require './support/active_record_rake_tasks'

# RSpec::Core::RakeTask.new(:spec)
Dir.glob('tasks/**/*.rake').each(&method(:import))

task :default => :spec
