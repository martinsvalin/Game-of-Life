window.Generation = (cells = [])->
  cells: cells
  tick: ->
    Survival.apply()
    Generation()

window.Survival = (cells)->
  apply: -> cells