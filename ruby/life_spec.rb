require './life'

describe "Any live cell with fewer than two live neighbours dies, as if caused by under-population." do
  subject { Life.new }
  describe "A game with only one live cell at coordinates 0,0" do
    before { subject.add_cell 0,0 }
    it "has a cell at 0,0 before the tick" do
      subject.cells.count.should == 1
      subject.cells.first.should be_at 0,0
    end

    it "has no survivors after one tick" do
      subject.tick!
      subject.cells.should be_empty
    end
  end

  describe "A game with two adjacent live cells, at coordinates 0,0 and 1,0" do
    before { subject.add_cells [0,0], [1,0] }
    it "has two cells, at 0,0 and 1,0 before the tick" do
      subject.cells.count.should == 2
      subject.cells.first.should be_at 0,0
      subject.cells.last.should be_at 1,0
    end

    it "has no survivors after one tick" do
      subject.tick!
      subject.cells.should be_empty
    end
  end
end

describe "Any live cell with two or three live neighbours lives on to the next generation." do
  subject { Life.new }
  describe "A game where one cell has two neighbors" do
    before { subject.add_cells [0,0], [1,0], [2,0] }
    it "has a survivor after one tick at 1,0" do
      subject.tick!
      subject.cells.should have_cell_at 1,0
    end
  end

  describe "A game where one cell has three neighbors" do
    before { subject.add_cells [0,0], [1,0], [2,0], [1,1] }
    it "has a survivor after one tick at 1,0" do
      subject.tick!
      subject.cells.should have_cell_at 1,0
    end
  end
end

describe "Any live cell with more than three live neighbours dies, as if by overcrowding." do
  subject { Life.new }
  describe "A game where one cell has four neighbors" do
    before { subject.add_cells [0,0], [1,0], [2,0], [1,1], [1,-1] }
    it "does not have a survivor at 1,0 after one tick" do
      subject.tick!
      subject.cells.should_not have_cell_at 1,0
    end
  end
end

describe "Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction." do
  subject { Life.new }
  describe "A game where a dead cell has three living neighbors" do
    before { subject.add_cells [0,0], [1,0], [2,0] }
    it "brings a dead cell back to life" do
      pending "need to implement #newborns and dead_cells first"
      subject.cells.should_not have_cell_at 1,1
      subject.tick!
      subject.cells.should have_cell_at 1,1
    end
  end
end

describe "private methods" do
  subject { Life.new }
  before do
    subject.add_cells [0,0], [1,0], [2,0], [10,0]
    @center_cell = subject.cells.first
    @center_cell.should be_at 0,0
  end

  describe "#survivors" do
    it "finds 1,0 as a survivor from 0,0; 1,0; 2,0 and 10,0" do
      subject.send(:survivors).should have_cell_at 1,0
    end

    it "has only one survivor from 0,0; 1,0; 2,0 and 10,0" do
      subject.send(:survivors).count.should == 1
    end
  end

  describe "#neighbors" do
    it "finds 1,0 as a neighbor to 0,0" do
      subject.send(:neighbors, @center_cell).should have_cell_at 1,0
    end

    it "does not find 0,0 as a neighbor to itself" do
      subject.send(:neighbors, @center_cell).should_not have_cell_at 0,0
    end

    it "only finds neighbors that are in the neighborhood of 0,0" do
      neighborhood = subject.send(:neighborhood, @center_cell)
      subject.send(:neighbors, @center_cell).should be_all {|cell| neighborhood.include? cell }
    end
  end

  describe "#neighborhood" do
    it "finds 0,0 and 1,0 in the neighborhood of 0,0" do
      subject.send(:neighborhood, @center_cell).should have_cell_at 0,0
      subject.send(:neighborhood, @center_cell).should have_cell_at 1,0
    end

    it "does not find 10,0 in the neighborhood of 0,0" do
      subject.send(:neighborhood, @center_cell).should_not have_cell_at 10,0
    end
  end

  describe "#newborns" do
    it "finds 1,1 as a newborn from 0,0; 1,0 and 2,0" do
      pending
    end
  end

  describe "#dead_cells" do
    it "finds a dead cell at -1,0 that could potentially come alive" do
      subject.dead_cells.should have_cell_at -1,0
    end
  end

  describe "#dead_and_alive_cells" do
    it "includes all alive cells" do
      subject.send(:dead_and_alive_cells).should include(*subject.cells)
    end
  end
end

RSpec::Matchers.define :be_at do |x, y|
  match do |cell|
    cell.x == x and cell.y == y
  end
end

RSpec::Matchers.define :have_cell_at do |x, y|
  match do |cells|
    cells.map {|cell| [cell.x, cell.y] }.include? [x,y]
  end
end