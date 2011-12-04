Given /^a generation with a? ?living cells? at ((\d+,\d+ ?)+)$/ do |coordinates, last|
  cells = parse(coordinates)
  @generation = Generation.new cells
end

When /^we tick to the next generation$/ do
  @generation = @generation.tick
end

Then /^the cell dies$/ do
  @generation.cells.should be_empty
end

Then /^we have a? ?surviving cells? at ((\d+,\d+ ?)+)$/ do |coordinates, last|
  cells = parse(coordinates)
  @generation.cells.should =~ cells
end

def parse(coordinates)
  # turn "0,0 1,1 2,2" into [[0,0], [1,1], [2,2]]
  coordinates.split(' ').map {|xy| xy.split(',').map(&:to_i)}
end