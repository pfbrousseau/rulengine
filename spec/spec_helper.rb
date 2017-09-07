require "bundler/setup"
require "rulengine"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      database: 'rulengine_test'
  )
end

ENV['ENV'] = 'test' # Ensure we don't drop the development database
# Dotenv.load('.env.test')
require 'bundler/gem_tasks'
require_relative '../support/active_record_rake_tasks'
Rake::Task['db:drop'].invoke
Rake::Task['db:create'].invoke

# move to task?
require "rulengine/setup_db"

# Rake::Task['db:structure:load'].invoke
