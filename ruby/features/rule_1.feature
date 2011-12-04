Feature: Any live cell with fewer than two live neighbours dies, as if caused by under-population

  In order to watch complex patterns arise from simple rules
  I want to generate repeated generations using Conway's four rules

Scenario: A world with one living cell
  Given a generation with a living cell at 0,0
  When we tick to the next generation
  Then the cell at 0,0 dies