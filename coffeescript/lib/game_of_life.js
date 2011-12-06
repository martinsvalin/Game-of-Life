
  window.Generation = function(cells) {
    if (cells == null) cells = [];
    return {
      cells: cells,
      tick: function() {
        Survival.for_cells(cells);
        return Generation();
      }
    };
  };

  window.Survival = {
    for_cells: function(cells) {
      var _this = this;
      return _.filter(cells, function(cell) {
        return Neighbourhood.living(cells, cell).length > 1;
      });
    }
  };

  window.Neighbourhood = {
    living: function(living_cells, center_cell) {
      return _.without(living_cells, center_cell);
    },
    around: function(center_cell) {
      var a, b, cells, x, y, _i, _j, _len, _len2, _ref, _ref2;
      x = center_cell[0], y = center_cell[1];
      cells = [];
      _ref = [x - 1, x, x + 1];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        a = _ref[_i];
        _ref2 = [y - 1, y, y + 1];
        for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
          b = _ref2[_j];
          if (!(a === x && b === y)) cells = cells.concat([[a, b]]);
        }
      }
      return cells;
    }
  };
