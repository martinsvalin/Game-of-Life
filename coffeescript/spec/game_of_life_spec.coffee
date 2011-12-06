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

    it 'with a single cell returns no survivors', ->
      rule = Survival([[0,0]])
      spyOn(rule, 'neighbour_count').andReturn 0
      expect(rule.apply()).toEqual []

    it 'with a block of four cells returns all cells as survivors', ->
      cells = [[0,0], [0,1], [1,0], [1,1]]
      rule = Survival(cells)
      spyOn(rule, 'neighbour_count').andReturn 3
      expect(rule.apply()).toEqual cells