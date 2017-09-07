require "spec_helper"

RSpec.describe Rulengine do
  it "rules on multiple inputs" do

    Rulengine::Rule.all.destroy_all

    Rulengine::Parser.text_to_rules('a requires b or c', true)
    Rulengine::Rule.apply_all_rules(['a', 'b'])
    # binding.pry
  end

end


