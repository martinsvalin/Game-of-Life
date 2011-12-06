
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
      return [];
    }
  };
