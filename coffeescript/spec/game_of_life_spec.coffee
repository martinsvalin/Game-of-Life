beforeEach ->
  @addMatchers
    toSerializeTo: (expected)->
      JSON.stringify(@actual) == JSON.stringify(expected);

describe 'generation', ->
  it 'should have a list of cells', ->
    expect(generation().cells).toEqual []

  describe 'with a cell at [0,0]', ->
    cells = [[0,0]]
    it 'should report its cell', ->
      expect(generation(cells).cells).toEqual cells

  it 'should tick to the next generation', ->
    expect(generation().tick()).toSerializeTo generation()

