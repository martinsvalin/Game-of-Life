
  window.Generation = function(cells) {
    if (cells == null) cells = [];
    return {
      cells: cells,
      tick: function() {
        Survival.apply();
        return Generation();
      }
    };
  };

  window.Survival = function(cells) {
    return {
      apply: function() {
        var _this = this;
        return _.filter(cells, function(cell) {
          return _this.neighbour_count(cell) > 1;
        });
      },
      neighbour_count: function(cell) {
        return 0;
      }
    };
  };
