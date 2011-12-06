
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
        spyOn(Survival, 'apply');
        Generation().tick();
        return expect(Survival.apply).toHaveBeenCalled();
      });
    });
  });

  describe('Survival', function() {
    return describe('apply', function() {
      it('returns a list of surviving cells', function() {
        return expect(Survival([]).apply()).toEqual([]);
      });
      it('with a single cell returns no survivors', function() {
        var rule;
        rule = Survival([[0, 0]]);
        spyOn(rule, 'neighbour_count').andReturn(0);
        return expect(rule.apply()).toEqual([]);
      });
      return it('with a block of four cells returns all cells as survivors', function() {
        var cells, rule;
        cells = [[0, 0], [0, 1], [1, 0], [1, 1]];
        rule = Survival(cells);
        spyOn(rule, 'neighbour_count').andReturn(3);
        return expect(rule.apply()).toEqual(cells);
      });
    });
  });
