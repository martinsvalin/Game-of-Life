class Reproduction
  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def self.apply(cells)
    []
  end

  def apply
    potential = cells.inject([]) do |potential, cell|
      potential + Neighbourhood.cells_around(*cell)
    end
    (potential.uniq - cells).select {|cell| neighbour_count(cell) == 3}
  end

  def neighbour_count(cell)
    (Neighbourhood.cells_around(*cell) & cells).length
  end
end