require './lib/generation'

describe "Generation" do
  let (:gen) { Generation.new }

  it "ticks to the next generation" do
    gen.tick.should be_instance_of Generation
  end
end