
  window.generation = function(cells) {
    if (cells == null) cells = [];
    return {
      cells: cells,
      tick: function() {
        Survival.apply();
        return generation();
      }
    };
  };

  window.Survival = function() {
    return {
      apply: function() {}
    };
  };
