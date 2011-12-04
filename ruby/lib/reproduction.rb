require './lib/rule'

class Reproduction < Rule
  def apply
    (potential.uniq - cells).select {|cell| neighbour_count(cell) == 3}
  end

  private
  def potential
    cells.inject([]) {|pot, cell| pot + Neighbourhood.cells_around(*cell) }
  end
end
