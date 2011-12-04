require './lib/survival'

describe "Survival" do
  context "with one cell" do
    let(:rule) { Survival.new [[0,0]]}
    it "dies" do
      rule.apply.should be_empty
    end
  end
end