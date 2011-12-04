require './lib/neighbourhood'

class Rule
  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def self.apply(cells)
    new(cells).apply
  end

  def neighbour_count(cell)
    (Neighbourhood.cells_around(*cell) & cells).length
  end
end
