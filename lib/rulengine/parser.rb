require "rulengine/rule"

module Rulengine
  class Parser < Object
    ACTIONS = ['requires', 'excludes'].freeze

    def self.text_to_rules(data, save=false)
      rules = []

      re = Regexp.new "(.*)(#{ACTIONS.join('|')})(.*)"
      _, left, action, right = re.match(data).to_a.map(&:strip)

      left = left.split(' and ')

      # Process right
      if right.include?' or ' # xor
        #  'a exclude (b XOR c) works' do
        # (Rule.new given: ['a', 'b'], unless_given: ['c'], action: {remove: ['b']} ).save!
        # (Rule.new given: ['a', 'c'], unless_given: ['b'], action: {remove: ['c']} ).save!

        a, b = right.split(' or ')
        built_action = Hash[action, [a]]
        rules << Rulengine::Rule.new(given:(left+[a]), unless_given:[b], action:built_action)

        rules << Rulengine::Rule.new(given:(left+[b]), unless_given:[a], action:built_action)

        rules << Rulengine::Rule.new(given:(left), unless_given:[a, b], action:{"choice" => [a, b]})
      else
        rules << self.rule_from_parts(left, action, right)
      end

      if save
        rules.map(&:save!)
      end
      rules

    end

    def self.rule_from_parts(left, action, right)
      # left = left.split(' and ') unless left.is_a? Array
      built_action = Hash[action, right.split(' and ')]
      Rulengine::Rule.new given:left, action:built_action
    end

  end
end