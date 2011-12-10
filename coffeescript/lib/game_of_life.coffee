window.Generation = (cells = [])->
  cells: cells
  # A new generation with surviving and newborn cells
  tick: ->
    Survival.for_cells(cells)
    Reproduction.for_cells(cells)
    Generation()

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
    _(@around(center_cell)).filter (neighbour_cell)->
      _(living_cells).any (living_cell)->
        living_cell == neighbour_cell

  # All unique dead cells around a list of living cells
  dead: (cells)->
    return [] if cells.length == 0
    Neighbourhood.around(cells[0])

  # All neighbouring cells, living or dead, around a center cell
  around: (center_cell)->
    [x,y] = CellConversion.fromString(center_cell)
    cells = []
    for a in [x-1, x, x+1]
      for b in [y-1, y, y+1]
        cells = cells.concat [CellConversion.toString([a,b])] unless a == x and b == y
    cells

window.CellConversion =
  fromString: (cell)->
    _(cell.split(":")).map (n)-> parseInt(n)
  toString: (cell)->
    cell.join(":")