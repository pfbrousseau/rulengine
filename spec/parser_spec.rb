require 'spec_helper'
require 'rulengine/rule'
require 'pry'

RSpec.describe Rulengine::Parser do
  it "has a version number" do
    expect(Rulengine::VERSION).not_to be nil
  end

  before(:each) do
    Rulengine::Rule.all.destroy_all
  end


  it 'parses' do
    Rulengine::Parser.text_to_rules('a requires b', true)
  end

  it 'finds conflicts' do
    Rulengine::Parser.text_to_rules('a requires b', true)
    Rulengine::Parser.text_to_rules('a excludes b', true)

    expect{ Rulengine::Rule.find_conflicts }.to raise_error(Rulengine::Rule::InvalidRuleSet)
  end

  it 'finds and conflicts' do
    Rulengine::Parser.text_to_rules('a and b requires c and d', true)
    Rulengine::Parser.text_to_rules('a excludes c', true)

    expect{ Rulengine::Rule.find_conflicts }.to raise_error(Rulengine::Rule::InvalidRuleSet)
  end

  it 'finds and conflicts (second)' do
    Rulengine::Parser.text_to_rules('a and b requires c and d', true)
    Rulengine::Parser.text_to_rules('b excludes d', true)

    expect{ Rulengine::Rule.find_conflicts }.to raise_error(Rulengine::Rule::InvalidRuleSet)
  end

  it 'chains: a -> bc' do
    # This is an unusual case: if you select a, it gets deselected and selects bc instead
    Rulengine::Parser.text_to_rules('a requires b', true)
    Rulengine::Parser.text_to_rules('b requires c', true)
    Rulengine::Parser.text_to_rules('c excludes a', true)

    # Rulengine::Rule.apply_all_rules(['a'])
    Rulengine::Rule.find_conflicts

  end

  it 'mutually exclusive (no information)' do
    # This is the '1=1' case: the second rule doesn't add information
    # Everything is already mutually exclusive
    Rulengine::Parser.text_to_rules('a excludes b', true)
    Rulengine::Parser.text_to_rules('b excludes a', true)

    Rulengine::Rule.find_conflicts

  end



  context 'xor' do

    it 'allows xor' do
      Rulengine::Parser.text_to_rules('a requires b or c', true)
      # more tests
      Rulengine::Rule.find_conflicts
    end

    it 'xor vs excludes' do
      Rulengine::Parser.text_to_rules('a requires b or c', true)
      Rulengine::Parser.text_to_rules('a excludes c', true)


      Rulengine::Rule.find_conflicts # This makes the or part useless but should still be allowed?
    end


    it 'parses xor' do
      rules = Rulengine::Parser.text_to_rules('a requires b or c', true)
      output = Rulengine::Rule.apply_all_rules(['a'])
      expect(output).to eq ["a", {"choice"=>["b", "c"]}].to_set

      # expect{ Rulengine::Rule.find_conflicts }.to raise_error(Rulengine::Rule::InvalidRuleSet)
    end
  end

end
