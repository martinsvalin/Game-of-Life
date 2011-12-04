Feature: Any live cell with two or three live neighbours lives on to the next generation

  In order to watch complex patterns arise from simple rules
  I want to generate repeated generations using Conway's four rules

Scenario: A world with a still life block of four living cells
  Given a generation with living cells at 0,0 1,0 0,1 1,1
  When we tick to the next generation
  Then we have surviving cells at 0,0 1,0 0,1 1,1