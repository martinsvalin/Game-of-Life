module Neighbourhood
  def self.cells_around(x, y)
    all = [x - 1, x, x + 1].product [y - 1, y, y + 1]
    all - [[x,y]]
  end
end
