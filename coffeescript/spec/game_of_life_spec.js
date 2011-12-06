
  beforeEach(function() {
    return this.addMatchers({
      toSerializeTo: function(expected) {
        return JSON.stringify(this.actual) === JSON.stringify(expected);
      }
    });
  });

  describe('Generation', function() {
    it('should have a list of cells', function() {
      return expect(Generation().cells).toEqual([]);
    });
    describe('with a cell at [0,0]', function() {
      var cells;
      cells = [[0, 0]];
      return it('should report its cell', function() {
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
