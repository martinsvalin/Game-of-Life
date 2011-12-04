Given /^a generation with a? ?living cells? at ((\d+,\d+ ?)+)$/ do |coordinates, last|
  cells = parse(coordinates)
  @generation = Generation.new cells
end

When /^we tick to the next generation$/ do
  @generation = @generation.tick
end

Then /^the cells? at ((\d+,\d+ ?)+) dies$/ do |coordinates, last|
  cells = parse(coordinates)
  @generation.cells.should_not include cells
end

Then /^we have a? ?surviving cells? at ((\d+,\d+ ?)+)$/ do |coordinates, last|
  cells = parse(coordinates)
  @generation.cells.should =~ cells
end

def parse(coordinates)
  # turn "0,0 1,1 2,2" into [[0,0], [1,1], [2,2]]
  coordinates.split(' ').map {|xy| xy.split(',').map(&:to_i)}
end