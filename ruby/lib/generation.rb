class Generation
  attr_reader :cells

  def initialize(cells = [])
    @cells = cells
  end

  def tick
    survivors = Survival.apply(cells)
    new_borns = Reproduction.apply(cells)
    Generation.new survivors
  end
end