require './lib/neighbourhood'

class Survival
  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def self.apply(cells)
    new(cells).apply
  end

  def apply
    cells.select do |cell|
      (2..3) === neighbour_count(cell)
    end
  end

  def neighbour_count(cell)
    (Neighbourhood.cells_around(*cell) & cells).length
  end
end
