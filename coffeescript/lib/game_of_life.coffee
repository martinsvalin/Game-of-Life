window.Generation = (cells = [])->
  cells: cells
  tick: ->
    Survival.for_cells(cells)
    Generation()

window.Survival =
  for_cells: (cells)->
    _.filter cells, (cell)=>
      Neighbourhood.living(cells, cell).length in (2..3)

window.Neighbourhood =
  living: (living_cells, center_cell)->
    _(@around(center_cell)).filter (neighbour_cell)->
      _(living_cells).any (living_cell)->
        living_cell[0] == neighbour_cell[0] and living_cell[1] == neighbour_cell[1]

  around: (center_cell)->
    [x,y] = center_cell
    cells = []
    for a in [x-1, x, x+1]
      for b in [y-1, y, y+1]
        cells = cells.concat [[a,b]] unless a == x and b == y
    cells
