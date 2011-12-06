(function() {
  var sameObject;

  sameObject = function(a, b) {
    return equal(JSON.stringify(a), JSON.stringify(b));
  };

  module('Generation');

  test('Generation should have a list of cells', function() {
    return same(generation().cells, []);
  });
