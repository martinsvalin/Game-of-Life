require './life'

describe "Any live cell with fewer than two live neighbours dies, as if caused by under-population."
describe "Any live cell with two or three live neighbours lives on to the next generation."
describe "Any live cell with more than three live neighbours dies, as if by overcrowding."
describe "Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction."