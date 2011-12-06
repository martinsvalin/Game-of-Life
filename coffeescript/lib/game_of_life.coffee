window.Generation = (cells = [])->
  cells: cells
  tick: ->
    Survival.apply()
    Generation()

window.Survival = (cells)->
  apply: ->
    _.filter cells, (cell)=>
      @neighbour_count(cell) > 1
  neighbour_count: (cell)-> 0