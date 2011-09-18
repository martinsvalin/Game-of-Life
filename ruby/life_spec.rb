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

  describe "A game with three live cells in a row, at 0,0; 1,0 and 2,0" do
    before { subject.add_cells [0,0], [1,0], [2,0] }
    it "has one survivor after one tick at 1,0" do
      subject.tick!
      subject.cells.should have_cell_at 1,0
    end
  end
end

describe "Any live cell with two or three live neighbours lives on to the next generation."
describe "Any live cell with more than three live neighbours dies, as if by overcrowding."
describe "Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction."

describe "private methods" do
  subject { Life.new }
  describe "#survivors" do
    it "finds 1,0 as a survivor from 0,0; 1,0 and 2,0" do
      pending
    end
  end
  describe "#neighbors" do
    it "finds 1,0 as a neighbor to 0,0" do
      pending
    end
  end
  describe "#neighborhood" do
    before do
      subject.add_cells [0,0], [1,0]
    end
    it "finds 0,0 and 1,0 in the neighborhood of 0,0" do
      cells = subject.cells
      cells.first.should be_at 0,0
      subject.send(:neighborhood, cells.first).should == cells
    end

    it "does not find 10,0 in the neighboorhood of 0,0" do
      subject.add_cell 10,0
      cells = subject.cells
      cells.first.should be_at 0,0
      subject.send(:neighborhood, cells.first).should_not have_cell_at 10,0
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