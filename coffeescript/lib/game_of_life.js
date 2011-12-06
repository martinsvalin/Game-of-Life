
  window.generation = function() {
    return {
      cells: [],
      tick: function() {
        return generation();
      }
    };
  };
