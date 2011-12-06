module 'Generation'

test 'Generation should have a list of cells', ->
  same generation().cells, []
