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
    @cells = []
  end

  private
  def neighborhood(center_cell)
    cells
  end
end