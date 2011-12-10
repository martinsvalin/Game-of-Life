(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (__hasProp.call(this, i) && this[i] === item) return i; } return -1; };

  window.Generation = function(cells) {
    if (cells == null) cells = [];
    return {
      cells: cells,
      tick: function() {
        Survival.for_cells(cells);
        Reproduction.for_cells(cells);
        return Generation();
      }
    };
  };

  window.Survival = {
    for_cells: function(cells) {
      var _this = this;
      return _.filter(cells, function(cell) {
        var _ref;
        return _ref = Neighbourhood.living(cells, cell).length, __indexOf.call([2, 3], _ref) >= 0;
      });
    }
  };

  window.Reproduction = {
    for_cells: function(cells) {
      return _(Neighbourhood.dead(cells)).filter(function(dead_cell) {
        return Neighbourhood.living(cells, dead_cell).length === 3;
      });
    }
  };

  window.Neighbourhood = {
    living: function(living_cells, center_cell) {
      return _(this.around(center_cell)).filter(function(neighbour_cell) {
        return _(living_cells).any(function(living_cell) {
          return living_cell === neighbour_cell;
        });
      });
    },
    dead: function(cells) {
      if (cells.length === 0) return [];
      return Neighbourhood.around(cells[0]);
    },
    around: function(center_cell) {
      var a, b, cells, x, y, _i, _j, _len, _len2, _ref, _ref2, _ref3;
      _ref = CellConversion.fromString(center_cell), x = _ref[0], y = _ref[1];
      cells = [];
      _ref2 = [x - 1, x, x + 1];
      for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
        a = _ref2[_i];
        _ref3 = [y - 1, y, y + 1];
        for (_j = 0, _len2 = _ref3.length; _j < _len2; _j++) {
          b = _ref3[_j];
          if (!(a === x && b === y)) {
            cells = cells.concat([CellConversion.toString([a, b])]);
          }
        }
      }
      return cells;
    }
  };

  window.CellConversion = {
    fromString: function(cell) {
      return _(cell.split(":")).map(function(n) {
        return parseInt(n);
      });
    },
    toString: function(cell) {
      return cell.join(":");
    }
  };

}).call(this);
