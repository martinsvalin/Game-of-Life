beforeEach ->
  @addMatchers
    toSerializeTo: (expected)->
      JSON.stringify(@actual) == JSON.stringify(expected);

describe 'Generation', ->
  it 'should have a list of cells', ->
    expect(Generation().cells).toEqual []

  describe 'with a cell at [0,0]', ->
    cells = [[0,0]]
    it 'should report its cell', ->
      expect(Generation(cells).cells).toEqual cells

  describe 'tick', ->
    it 'should tick to the next Generation', ->
      expect(Generation().tick()).toSerializeTo Generation()

    it 'should apply Survival rules', ->
      spyOn Survival, 'apply'
      Generation().tick()
      expect(Survival.apply).toHaveBeenCalled()