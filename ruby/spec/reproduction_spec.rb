require './lib/reproduction'

describe "Reproduction" do
  context "with three cells (blinker)" do
    let(:cells) { [[1,0], [1,1], [1,2]]}
    let(:rule) { Reproduction.new cells }
    it "spawns two new cells, above and below 1,1" do
      rule.apply.should =~ [[0,1], [2,1]]
    end
  end
end
