window.Generation = (cells = [])->
  cells: cells
  # A new generation with surviving and newborn cells
  tick: ->
    next_gen = Survival.for_cells(cells)
    next_gen = next_gen.concat Reproduction.for_cells(cells)
    next_gen = _(next_gen).sort()
    Generation(next_gen)

window.Survival =
  # All living cells with two or three living neighbours
  for_cells: (cells)->
    _.filter cells, (cell)=>
      Neighbourhood.living(cells, cell).length in [2..3]

window.Reproduction =
  # All dead cells with exactly three living neighbours
  for_cells: (cells)->
    _(Neighbourhood.dead(cells)).filter (dead_cell)->
      Neighbourhood.living(cells, dead_cell).length == 3

window.Neighbourhood =
  # Neighbouring living cells around a center cell
  living: (living_cells, center_cell)->
    _(@around(center_cell)).intersection living_cells

  # All unique dead cells around a list of living cells
  dead: (cells)->
    all_dead = _(cells).map (cell)=>
      _(@around(cell)).difference cells
    _(all_dead).chain().flatten().uniq().sort().value()

  # All neighbouring cells, living or dead, around a center cell
  around: (center_cell)->
    [x,y] = CellConversion.fromString(center_cell)
    cells = []
    for a in [x-1, x, x+1]
      for b in [y-1, y, y+1]
        cells = cells.concat [CellConversion.toString([a,b])] unless a == x and b == y
    cells

CellConversion =
  fromString: (cell)->
    _(cell.split(":")).map (n)-> parseInt(n)
  toString: (cell)->
    cell.join(":")