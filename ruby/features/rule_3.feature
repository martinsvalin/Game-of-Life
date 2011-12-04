Feature: Any live cell with more than three live neighbours dies, as if by overcrowding

  In order to watch complex patterns arise from simple rules
  I want to generate repeated generations using Conway's four rules

Scenario: A world with five living cells in a cross formation
  Given a generation with living cells at 1,0 1,1 1,2 0,1 2,1
  When we tick to the next generation
  Then the cell at 1,1 dies