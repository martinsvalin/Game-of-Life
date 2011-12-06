
  module('Generation');

  test('Generation should have a list of cells', function() {
    return same(generation().cells, []);
  });
