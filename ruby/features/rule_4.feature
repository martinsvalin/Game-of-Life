Feature: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction

  In order to watch complex patterns arise from simple rules
  I want to generate repeated generations using Conway's four rules

Scenario: A world with a blinker, three living cells in a row
  Given a generation with living cells at 1,0 1,1 1,2
  When we tick to the next generation
  Then we have surviving cells at 0,1 1,1 2,1