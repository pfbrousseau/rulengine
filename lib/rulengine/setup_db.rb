require 'active_record'

ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'rulengine_development'
)
ActiveRecord::Base.connection

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
