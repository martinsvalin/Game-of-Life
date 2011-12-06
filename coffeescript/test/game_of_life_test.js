(function() {
  var sameObject;

  sameObject = function(a, b) {
    return equal(JSON.stringify(a), JSON.stringify(b));
  };

  module('Generation');

  test('Generation should have a list of cells', function() {
    return same(generation().cells, []);
  });

  test('Generation should tick to the next generation', function() {
    return sameObject(generation().tick(), generation());
  });

}).call(this);
