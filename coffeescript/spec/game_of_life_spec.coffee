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
      cells = ["0:0"]
      expect(Generation(cells).cells).toEqual cells

  describe 'tick', ->
    it 'should tick to the next Generation', ->
      expect(Generation().tick()).toSerializeTo Generation()

    it 'should apply Survival rules', ->
      spyOn(Survival, 'for_cells').andReturn []
      Generation().tick()
      expect(Survival.for_cells).toHaveBeenCalledWith([])

    it 'should apply Reproduction rules', ->
      spyOn Reproduction, 'for_cells'
      Generation().tick()
      expect(Reproduction.for_cells).toHaveBeenCalledWith([])

    it 'should pass on survivors and newborns to the next Generation', ->
      gen = Generation(["1:1", "1:2", "1:3"]).tick()
      expect(gen.cells).toEqual ["0:2", "1:2", "2:2"]

describe 'Survival', ->
  describe 'for_cells', ->
    it 'returns a list of surviving cells', ->
      expect(Survival.for_cells([])).toEqual []

    it 'with a single cell returns no survivors', ->
      spyOn(Neighbourhood, 'living').andReturn 0
      expect(Survival.for_cells(["0:0"])).toEqual []

    it 'with a block of four cells returns all cells as survivors', ->
      cells = [
        "0:0", "0:1",
        "1:0", "1:1"
      ]
      # Stub Neighbourhood. Not correct, but works as long as length is 3
      spyOn(Neighbourhood, 'living').andReturn [
        "0:0", "0:1",
        "1:0"
      ]
      expect(Survival.for_cells(cells)).toEqual cells

    it "with five cells in a cross does not return the center cell", ->
      cells = ["0:1",
        "1:0", "1:1", "1:2",
               "2:1"]
      expect(Survival.for_cells(cells)).toEqual [
               "0:1",
        "1:0",        "1:2",
               "2:1"]

describe 'Reproduction', ->
  describe 'for_cells', ->
    it 'returns a list of newborn cells', ->
      expect(Reproduction.for_cells([])).toEqual []

    it 'with a blinker (three cells) returns two newborn cells', ->
      cells = [
        "0:1",
        "1:1",
        "2:1"]
      spyOn(Neighbourhood, 'dead').andReturn ["1:0", "1:2"]
      expect(Reproduction.for_cells(cells)).toEqual ["1:0", "1:2"]

describe 'Neighbourhood', ->
  describe 'living', ->
    it "doesn't include itself", ->
      living_cells = ["0:0"]
      center_cell = _(living_cells).first()
      expect(Neighbourhood.living(living_cells, center_cell)).not.toContain center_cell

    it "finds some living neighbours", ->
      living_cells = [
        "0:0", "0:1",
        "1:0", "1:1"
      ]
      center_cell = _(living_cells).first()
      expect(Neighbourhood.living(living_cells, center_cell)).toEqual [
               "0:1",
        "1:0", "1:1"
      ]

    it "excludes live cells that are not neighbours", ->
      living_cells = [
        "0:0",

                      "2:2"]
      center_cell = _(living_cells).first()
      expect(Neighbourhood.living(living_cells, center_cell)).toEqual []

  describe 'dead', ->
    it "is empty for no living cells", ->
      expect(Neighbourhood.dead([])).toEqual []

    it "is the entire neighbourhood for a single living cell", ->
      expect(Neighbourhood.dead(["0:0"])).toEqual Neighbourhood.around("0:0")

    it "has all dead neighbours, but no living neighbours", ->
      expected = [
        "4:4", "4:5", "4:6", "4:7",
        "5:4",               "5:7",
        "6:4", "6:5", "6:6", "6:7"
      ]
      expect(Neighbourhood.dead(["5:5", "5:6"])).toEqual expected

  describe 'around', ->
    it "finds all cells around the center cell", ->
      expected = [
        "4:4", "4:5", "4:6",
        "5:4",        "5:6",
        "6:4", "6:5", "6:6"
      ]
      expect(Neighbourhood.around("5:5")).toEqual expected