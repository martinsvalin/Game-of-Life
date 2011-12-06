
  beforeEach(function() {
    return this.addMatchers({
      toSerializeTo: function(expected) {
        return JSON.stringify(this.actual) === JSON.stringify(expected);
      }
    });
  });

  describe('Generation', function() {
    describe('cells', function() {
      it('should have a list of cells', function() {
        return expect(Generation().cells).toEqual([]);
      });
      return it('with a cell at [0,0] should report its cell', function() {
        var cells;
        cells = [[0, 0]];
        return expect(Generation(cells).cells).toEqual(cells);
      });
    });
    return describe('tick', function() {
      it('should tick to the next Generation', function() {
        return expect(Generation().tick()).toSerializeTo(Generation());
      });
      return it('should apply Survival rules', function() {
        spyOn(Survival, 'for_cells');
        Generation().tick();
        return expect(Survival.for_cells).toHaveBeenCalledWith([]);
      });
    });
  });

  describe('Survival', function() {
    return describe('for_cells', function() {
      it('returns a list of surviving cells', function() {
        return expect(Survival.for_cells([])).toEqual([]);
      });
      it('with a single cell returns no survivors', function() {
        spyOn(Neighbourhood, 'living').andReturn(0);
        return expect(Survival.for_cells([[0, 0]])).toEqual([]);
      });
      return it('with a block of four cells returns all cells as survivors', function() {
        var cells;
        cells = [[0, 0], [0, 1], [1, 0], [1, 1]];
        spyOn(Neighbourhood, 'living').andReturn([[0, 0], [0, 1], [1, 0]]);
        return expect(Survival.for_cells(cells)).toEqual(cells);
      });
    });
  });

  describe('Neighbourhood', function() {
    return describe('living', function() {
      return it("doesn't include itself", function() {
        return expect(Neighbourhood.living([[0, 0]], [0, 0])).not.toContain([0, 0]);
      });
    });
  });
