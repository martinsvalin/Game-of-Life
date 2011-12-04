class Generation
  attr_reader :cells

  def initialize(cells = [])
    @cells = cells
  end

  def tick
    survivors = Survival.apply(cells)
    newborns = Reproduction.apply(cells)
    Generation.new survivors + newborns
  end
end