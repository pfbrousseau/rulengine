require "active_record"
require "rulengine/version"

# Move?
require "rulengine/rule"
require "rulengine/state"
require "rulengine/parser"


# require 'pry'


# TODO
require "active_record"
require 'yaml'
config   = YAML::load(IO.read("config/database.yml"))['development']

host     = config["host"]
database = config["database"]
username = config["username"]
password = config["password"]

ActiveRecord::Base.establish_connection(
  adapter:  'postgresql', # or 'postgresql' or 'sqlite3'
  database: database,
  username: username,
  password: password,
  host:     host
)

module Rulengine
	class Engine 

    # TODO
    def self.build_db
      ActiveRecord::Schema.define do
        unless ActiveRecord::Base.connection.tables.include? 'rules'
          create_table :rules do |t|
            t.json :given # Turns this an its negative into a separate 'fact' class
            t.json :unless_given # Same as "and not given"
            t.json :action # switch to foreign key? Model name? (inherited)

            t.timestamps
          end
        end

        unless ActiveRecord::Base.connection.tables.include? 'states'
          create_table :states do |t|
            t.json :data
            t.timestamps
          end
        end
      end
    end

		def initialize
			puts "init rulengine"
      
      # binding.pry

      # config   = YAML::load(IO.read("config/database.yml"))['development']

      # host     = config["host"]
      # database = config["database"]
      # username = config["username"]
      # password = config["password"]

      # ActiveRecord::Base.establish_connection(
      #   adapter:  'postgresql', # or 'postgresql' or 'sqlite3'
      #   database: database,
      #   username: username,
      #   password: password,
      #   host:     host
      # )

      Rulengine::Engine.build_db
      Rulengine::Rule.connection


		end

		def self.a
			puts 'a'
			'a'
		end
		
	end
end

Rulengine::Engine.new
