require './lib/generation'

describe "Generation" do
  let(:gen) { Generation.new }

  it "ticks to the next generation" do
    gen.tick.should be_instance_of Generation
  end

  it "reports its cells" do
    gen.cells.should be_empty
  end

  context "with one living cell at 0,0" do
    let(:gen) { Generation.new [[0,0]] }

    it "reports its cell" do
      gen.cells.should =~ [[0,0]]
    end
  end

  context "with a still life block of living cells" do
    let(:cells) { [[0,0], [0,1], [1,0], [1,1]] }
    let(:gen) { Generation.new cells }

    it "reports its cells" do
      gen.cells.should =~ cells
    end
  end
end