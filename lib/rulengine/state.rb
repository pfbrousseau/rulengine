module Rulengine
  class State < ActiveRecord::Base
    BadInput = Class.new StandardError

    def apply_rule(rule)
      raise BadInput unless rule.is_a? Rule
      self.data = Rule.first.apply_to(data.to_set)
    end

    def to_set
      @data_set ||= data.to_set
    end

    def data=(value)
      super(value)
      @data_set = nil # Clear cached data set
    end
  end
end