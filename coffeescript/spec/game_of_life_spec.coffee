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

    it 'should apply Reproduction rules', ->
      spyOn Reproduction, 'for_cells'
      Generation().tick()
      expect(Reproduction.for_cells).toHaveBeenCalledWith([])

describe 'Survival', ->
  describe 'for_cells', ->
    it 'returns a list of surviving cells', ->
      expect(Survival.for_cells([])).toEqual []

    it 'with a single cell returns no survivors', ->
      spyOn(Neighbourhood, 'living').andReturn 0
      expect(Survival.for_cells([[0,0]])).toEqual []

    it 'with a block of four cells returns all cells as survivors', ->
      cells = [
        [0,0], [0,1],
        [1,0], [1,1]
      ]
      # Stub Neighbourhood. Not correct, but works as long as length is 3
      spyOn(Neighbourhood, 'living').andReturn [
        [0,0], [0,1],
        [1,0]
      ]
      expect(Survival.for_cells(cells)).toEqual cells

    it "with five cells in a cross does not return the center cell", ->
      cells = [[0,1],
        [1,0], [1,1], [1,2],
               [2,1]]
      expect(Survival.for_cells(cells)).toEqual [
               [0,1],
        [1,0],        [1,2],
               [2,1]]

describe 'Reproduction', ->
  describe 'for_cells', ->
    it 'returns a list of newborn cells', ->
      expect(Reproduction.for_cells([])).toEqual []

describe 'Neighbourhood', ->
  describe 'living', ->
    it "doesn't include itself", ->
      living_cells = [[0,0]]
      center_cell = _(living_cells).first()
      expect(Neighbourhood.living(living_cells, center_cell)).not.toContain center_cell

    it "finds some living neighbours", ->
      living_cells = [
        [0,0], [0,1],
        [1,0], [1,1]
      ]
      center_cell = _(living_cells).first()
      expect(Neighbourhood.living(living_cells, center_cell)).toEqual [
               [0,1],
        [1,0], [1,1]
      ]

    it "excludes live cells that are not neighbours", ->
      living_cells = [
        [0,0],

                      [2,2]
      ]
      center_cell = _(living_cells).first()
      expect(Neighbourhood.living(living_cells, center_cell)).toEqual []

  describe 'around', ->
    it "finds all cells around the center cell", ->
      expected = [
        [4,4], [4,5], [4,6],
        [5,4],        [5,6],
        [6,4], [6,5], [6,6]
      ]
      expect(Neighbourhood.around([5,5])).toEqual expected