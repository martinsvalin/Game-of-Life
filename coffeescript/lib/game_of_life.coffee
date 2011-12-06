window.generation = (cells = [])->
  cells: cells
  tick: ->
    Survival.apply()
    generation()

window.Survival = ->
  apply: ->