
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

  window.Survival = function() {
    return {
      apply: function() {}
    };
  };
