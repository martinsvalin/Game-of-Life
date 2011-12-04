require './lib/survival'

describe "Survival" do
  context "with one cell" do
    let(:rule) { Survival.new [[0,0]]}
    it "dies" do
      rule.should_receive(:neighbour_count).once.and_return(0)
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

  context "with six cells, two by three" do
    let(:cells) { [[0,0], [0,1], [0,2], [1,0], [1,1], [1,2]] }
    let(:rule) { Survival.new cells }
    it "has four survivors, but the middle cells die" do
      rule.apply.should =~ (cells - [[0,1], [1,1]])
    end
  end
end
