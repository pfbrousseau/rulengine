require "active_record"

require "rulengine/version"

# Move?
require "rulengine/rule"
require "rulengine/state"

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
      build_db
		end

		def self.a
			puts 'a'
			'a'
		end
		
	end
end

