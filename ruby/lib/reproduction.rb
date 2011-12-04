require './lib/rule'

class Reproduction < Rule
  def apply
    potential = cells.inject([]) do |potential, cell|
      potential + Neighbourhood.cells_around(*cell)
    end
    (potential.uniq - cells).select {|cell| neighbour_count(cell) == 3}
  end
end
