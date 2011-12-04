require './lib/generation'

describe "Generation" do
  describe "#cells" do
    context "with no living cells" do
      let(:gen) { Generation.new }

      it "reports its cells" do
        gen.cells.should be_empty
      end      
    end    

    context "with one living cell" do
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

  describe "#tick" do
    let(:gen) { Generation.new }
    it "returns the next generation" do
      gen.tick.should be_instance_of Generation
    end

    it "applies rules for survival on living cells" do
      Survival.should_receive(:apply).with(gen.cells).and_return []
      gen.tick
    end

    it "applies rules for reproduction on living cells" do
      Reproduction.should_receive(:apply).with(gen.cells).and_return []
      gen.tick
    end

    it "should include survivors in the next generation" do
      Survival.should_receive(:apply).and_return([[1,1]])
      next_gen = gen.tick
      next_gen.cells.should include [1,1]
    end

    it "should include newborn cells in the next generation" do
      Reproduction.should_receive(:apply).and_return([[2,2]])
      next_gen = gen.tick
      next_gen.cells.should include [2,2]
    end
  end
end