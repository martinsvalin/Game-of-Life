beforeEach ->
  @addMatchers
    # "good enough" object comparison
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
      spyOn Survival, 'for_cells'
      Generation().tick()
      expect(Survival.for_cells).toHaveBeenCalledWith([])

describe 'Survival', ->
  describe 'for_cells', ->
    it 'returns a list of surviving cells', ->
      expect(Survival.for_cells([])).toEqual []

    it 'with a single cell returns no survivors', ->
      spyOn(Neighbourhood, 'living').andReturn 0
      expect(Survival.for_cells([[0,0]])).toEqual []

    it 'with a block of four cells returns all cells as survivors', ->
      cells = [[0,0], [0,1], [1,0], [1,1]]
      # Stub Neighbourhood. Not correct, but works as long as length is 3
      spyOn(Neighbourhood, 'living').andReturn [[0,0], [0,1], [1,0]]
      expect(Survival.for_cells(cells)).toEqual cells

describe 'Neighbourhood', ->
  describe 'living', ->
    it "doesn't include itself", ->
      expect(Neighbourhood.living([[0,0]], [0,0])).not.toContain [0,0]