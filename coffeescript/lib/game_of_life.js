
  window.generation = function(cells) {
    if (cells == null) cells = [];
    return {
      cells: cells,
      tick: function() {
        return generation();
      }
    };
  };
