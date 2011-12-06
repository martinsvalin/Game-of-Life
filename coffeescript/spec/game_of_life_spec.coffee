beforeEach ->
  @addMatchers
    toSerializeTo: (expected)->
      JSON.stringify(@actual) == JSON.stringify(expected);

describe 'Generation', ->
  describe 'cells', ->
    it 'should have a list of cells', ->
      expect(Generation().cells).toEqual []

    it 'with a cell at [0,0] should report its cell', ->
      cells = [[0,0]]
      expect(Generation(cells).cells).toEqual cells

  describe 'tick', ->
    it 'should tick to the next Generation', ->
      expect(Generation().tick()).toSerializeTo Generation()

    it 'should apply Survival rules', ->
      spyOn Survival, 'apply'
      Generation().tick()
      expect(Survival.apply).toHaveBeenCalled()

describe 'Survival', ->
  describe 'apply', ->
    it 'returns a list of surviving cells', ->
      expect(Survival([]).apply()).toEqual []