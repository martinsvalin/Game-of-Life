class Generation
  attr_reader :cells

  def initialize(cells = [])
    @cells = cells
  end

  def tick
    self
  end
end