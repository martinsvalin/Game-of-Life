require 'ostruct'

class Life
  attr_reader :cells
  def initialize
    @cells = []
  end

  def add_cells(*coordinates)
    coordinates.each do |x,y|
      add_cell(x,y)
    end
  end

  def add_cell(x, y)
    @cells << OpenStruct.new(x: x, y: y)
  end

  def tick!
    @cells = survivors
  end

  private
  def survivors
    cells.select {|cell| (2..3).include? neighbors(cell).count }
  end

  def neighbors(cell)
    neighborhood(cell) - [cell]
  end

  def neighborhood(center_cell)
    cells.select do |cell|
      (cell.x - center_cell.x).abs <= 1 and
      (cell.y - center_cell.y).abs <= 1
    end
  end

  def dead_cells
    dead_and_alive_cells
  end

  def dead_and_alive_cells
    cells.inject([]) do |all_cells, cell|
      all_cells + complete_neighborhood(cell)
    end
  end

  def coordinates_in_neighborhood(cell)
    x, y = cell.x, cell.y
    [
      [x-1, y+1], [x, y+1], [x+1, y+1],
      [x-1, y  ], [x, y  ], [x+1, y  ],
      [x-1, y-1], [x, y-1], [x+1, y-1]
    ]
  end
end