require "active_record"

require "rulengine/version"
require "rulengine/rule"

module Rulengine
  


	class Engine 

		def initialize
			# build_db
			puts "init rulengine"

		end

		def self.a
			puts 'a'
			'a'
		end
		
		# def build_db
		#   ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: 'database.db'
		# 	ActiveRecord::Schema.define do
		#   unless ActiveRecord::Base.connection.tables.include? 'rules'
		#     create_table :rules do |t|
		#       t.json :given
		#       t.json :unless_given # Same as "and not given"
		#       t.json :action # switch to foreign key? Model name? (inherited)

		#       t.timestamps
		#     end
		#   end
		# end
		
	end
end

