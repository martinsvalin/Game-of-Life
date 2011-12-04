require './lib/survival'

describe "Survival" do
  context "with one cell" do
    let(:rule) { Survival.new [[0,0]]}
    it "dies" do
      rule.apply.should be_empty
    end
  end

  context "with a block of four cells" do
    let(:cells) { [[0,0], [0,1], [1,0], [1,1]] }
    let(:rule) { Survival.new cells }
    it "survives" do
      rule.should_receive(:neighbour_count).exactly(4).times.and_return(3)
      rule.apply.should =~ cells
    end
  end
end