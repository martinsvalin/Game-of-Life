sameObject = (a, b)->
  equal JSON.stringify(a), JSON.stringify(b)

module 'Generation'

test 'Generation should have a list of cells', ->
  same generation().cells, []

test 'Generation should tick to the next generation', ->
  sameObject generation().tick(), generation()