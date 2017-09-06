require "active_record"
require "set"

ActiveRecord::Base.connection


module Rulengine
  class Rule < ActiveRecord::Base
    InvalidRuleSet = Class.new StandardError

    def self.list_all_combinations
      # Shortcut, can be greatly optimized
      left = Rulengine::Rule.all.pluck(:given, :unless_given).flatten.to_set
      right = Rulengine::Rule.all.pluck(:action).map(&:values).flatten.to_set
      vars = left + right - [nil]
      # For optimization, remove to_a (less readable)
      (1..vars.count).flat_map{ |size| vars.to_a.combination(size).to_a }

    end

  
    def self.find_conflicts # Don't pass data, generate it!
      list_all_combinations.each do |data|
        puts "Testing combination: #{data}"
        data = apply_all_rules(data)
        apply_all_rules(data)
      end
      # data = apply_all_rules(data)
      # apply_all_rules(data)
    end

    def self.apply_all_rules(data, run_count=1)
      # Run twice ensures there are no deep circular conflicts
      data = data.to_set
      state_history = Set.new([data])

      # run_count = (run_twice && 2) || 1
      (1..run_count).each do |_|
        Rulengine::Rule.all.each do |rule|
          # orig_state = self #.deep_copy
          data_was = data
          data = rule.apply_to(data)
          if data_was != data
            if state_history.include? data.to_set
              raise InvalidRuleSet, [rule, state_history, ]# "Breaking input: #{state_history.first}"]
            end
            state_history.add data.to_set
          end
        end
      end

      # puts state_history
      data
    end


    # Not_given refers to something that MUST NOT be given
    def apply_to(data)
      # data = data.data if data.is_a? State
      data = data.to_set unless data.is_a? Set
      if applies?(data)

        # Refactor action into classes with `perform` and use a hash to make O(1) !
        action.each do |k, v|
          if (k.eql? 'add') || (k.eql? 'requires')
            data += (v || [])
          elsif (k.eql? 'remove') || (k.eql? 'excludes')
            data -= (v || [])
          else
            puts k, v
            raise NotImplementedError
          end
        end
        # self.save!
      end

      data
    end

    def applies?(data)
      if unless_given
        return false if (data & unless_given).present?
      end
      if given
        return false unless given.to_set.subset? data
      end

      true
    end
  end
end
