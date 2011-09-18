require 'ostruct'

class Life
  attr_reader :cells
  def initialize
    @cells = []
  end

  def tick!
    @cells = []
  end

  def add_cell(x, y)
    @cells << OpenStruct.new(x: y, y: y)
  end
end