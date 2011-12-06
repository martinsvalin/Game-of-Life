window.Generation = (cells = [])->
  cells: cells
  tick: ->
    Survival.for_cells(cells)
    Generation()

window.Survival =
  for_cells: (cells)->
    _.filter cells, (cell)=>
      Neighbourhood.living(cells, cell).length > 1

window.Neighbourhood =
  living: (living_cells, center_cell)->
    []