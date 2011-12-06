
  beforeEach(function() {
    return this.addMatchers({
      toSerializeTo: function(expected) {
        return JSON.stringify(this.actual) === JSON.stringify(expected);
      }
    });
  });

  describe('generation', function() {
    it('should have a list of cells', function() {
      return expect(generation().cells).toEqual([]);
    });
    describe('with a cell at [0,0]', function() {
      var cells;
      cells = [[0, 0]];
      return it('should report its cell', function() {
        return expect(generation(cells).cells).toEqual(cells);
      });
    });
    return it('should tick to the next generation', function() {
      return expect(generation().tick()).toSerializeTo(generation());
    });
  });
