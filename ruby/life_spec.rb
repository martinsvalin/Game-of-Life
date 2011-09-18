require './life'

describe "Any live cell with fewer than two live neighbours dies, as if caused by under-population." do
  describe "A game with only one live cell at coordinates 0,0" do
    subject { Life.new }
    before { subject.add_cell(0,0) }
    it "has a cell at 0,0 before the tick" do
      subject.cells.count.should == 1
      subject.cells.first.should be_at(0,0)
    end
  end
end

describe "Any live cell with two or three live neighbours lives on to the next generation."
describe "Any live cell with more than three live neighbours dies, as if by overcrowding."
describe "Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction."

RSpec::Matchers.define :be_at do |x, y|
  match do |cell|
    cell.x == x and cell.y == y
  end
end