require './lib/rule'

class Survival < Rule
  def apply
    cells.select do |cell|
      (2..3) === neighbour_count(cell)
    end
  end
end
