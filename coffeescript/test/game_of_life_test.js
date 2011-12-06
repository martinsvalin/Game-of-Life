(function() {
  var sameObject;

  sameObject = function(a, b) {
    return equal(JSON.stringify(a), JSON.stringify(b));
  };

  module('Generation');

  test('Generation should have a list of cells', function() {
    return same(generation().cells, []);
  });

  test('Generation with a cell reports its cell', function() {
    return same(generation([[0, 0]]).cells, [[0, 0]]);
  });

  test('Generation should tick to the next generation', function() {
    return sameObject(generation().tick(), generation());
  });

}).call(this);
