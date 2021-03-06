
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
        cells = ["0:0"];
        return expect(Generation(cells).cells).toEqual(cells);
      });
    });
    return describe('tick', function() {
      it('should tick to the next Generation', function() {
        return expect(Generation().tick()).toSerializeTo(Generation());
      });
      it('should apply Survival rules', function() {
        spyOn(Survival, 'for_cells').andReturn([]);
        Generation().tick();
        return expect(Survival.for_cells).toHaveBeenCalledWith([]);
      });
      it('should apply Reproduction rules', function() {
        spyOn(Reproduction, 'for_cells');
        Generation().tick();
        return expect(Reproduction.for_cells).toHaveBeenCalledWith([]);
      });
      return it('should pass on survivors and newborns to the next Generation', function() {
        var gen;
        gen = Generation(["1:1", "1:2", "1:3"]).tick();
        return expect(gen.cells).toEqual(["0:2", "1:2", "2:2"]);
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
        return expect(Survival.for_cells(["0:0"])).toEqual([]);
      });
      it('with a block of four cells returns all cells as survivors', function() {
        var cells;
        cells = ["0:0", "0:1", "1:0", "1:1"];
        spyOn(Neighbourhood, 'living').andReturn(["0:0", "0:1", "1:0"]);
        return expect(Survival.for_cells(cells)).toEqual(cells);
      });
      return it("with five cells in a cross does not return the center cell", function() {
        var cells;
        cells = ["0:1", "1:0", "1:1", "1:2", "2:1"];
        return expect(Survival.for_cells(cells)).toEqual(["0:1", "1:0", "1:2", "2:1"]);
      });
    });
  });

  describe('Reproduction', function() {
    return describe('for_cells', function() {
      it('returns a list of newborn cells', function() {
        return expect(Reproduction.for_cells([])).toEqual([]);
      });
      return it('with a blinker (three cells) returns two newborn cells', function() {
        var cells;
        cells = ["0:1", "1:1", "2:1"];
        spyOn(Neighbourhood, 'dead').andReturn(["1:0", "1:2"]);
        return expect(Reproduction.for_cells(cells)).toEqual(["1:0", "1:2"]);
      });
    });
  });

  describe('Neighbourhood', function() {
    describe('living', function() {
      it("doesn't include itself", function() {
        var center_cell, living_cells;
        living_cells = ["0:0"];
        center_cell = _(living_cells).first();
        return expect(Neighbourhood.living(living_cells, center_cell)).not.toContain(center_cell);
      });
      it("finds some living neighbours", function() {
        var center_cell, living_cells;
        living_cells = ["0:0", "0:1", "1:0", "1:1"];
        center_cell = _(living_cells).first();
        return expect(Neighbourhood.living(living_cells, center_cell)).toEqual(["0:1", "1:0", "1:1"]);
      });
      return it("excludes live cells that are not neighbours", function() {
        var center_cell, living_cells;
        living_cells = ["0:0", "2:2"];
        center_cell = _(living_cells).first();
        return expect(Neighbourhood.living(living_cells, center_cell)).toEqual([]);
      });
    });
    describe('dead', function() {
      it("is empty for no living cells", function() {
        return expect(Neighbourhood.dead([])).toEqual([]);
      });
      it("is the entire neighbourhood for a single living cell", function() {
        return expect(Neighbourhood.dead(["0:0"])).toEqual(Neighbourhood.around("0:0"));
      });
      return it("has all dead neighbours, but no living neighbours", function() {
        var expected;
        expected = ["4:4", "4:5", "4:6", "4:7", "5:4", "5:7", "6:4", "6:5", "6:6", "6:7"];
        return expect(Neighbourhood.dead(["5:5", "5:6"])).toEqual(expected);
      });
    });
    return describe('around', function() {
      return it("finds all cells around the center cell", function() {
        var expected;
        expected = ["4:4", "4:5", "4:6", "5:4", "5:6", "6:4", "6:5", "6:6"];
        return expect(Neighbourhood.around("5:5")).toEqual(expected);
      });
    });
  });
