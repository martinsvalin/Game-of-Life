require './lib/rule'

describe "Rule" do

  describe "apply" do
    it "should return survivors" do
      Rule.any_instance.stub(:apply).and_return([[1,1]])
      Rule.apply([]).should =~ [[1,1]]
    end
  end

  describe "#neighbour_count" do
    context "with one cell" do
      let(:rule) { Rule.new [[0,0]]}
      it "finds no neighbours" do
        rule.neighbour_count(rule.cells.first).should eq(0)
      end
    end

    context "with a block of cells" do
      let(:cells) { [[0,0], [0,1], [1,0], [1,1]] }
      let(:rule) { Rule.new cells }
      it "finds three neighbours for each of the cells" do
        cells.each do |cell|
          rule.neighbour_count(cell).should eq(3)
        end
      end
    end
  end  
end
