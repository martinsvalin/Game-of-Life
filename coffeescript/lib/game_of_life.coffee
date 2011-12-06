window.Generation = (cells = [])->
  cells: cells
  tick: ->
    Survival.apply()
    Generation()

window.Survival = ->
  apply: ->