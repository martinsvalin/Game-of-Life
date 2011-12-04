Feature: Any live cell with more than three live neighbours dies, as if by overcrowding

  In order to watch complex patterns arise from simple rules
  I want to generate repeated generations using Conway's four rules

Scenario: A world with six living cells close to each other
  Given a generation with living cells at 0,0 0,1 0,2 1,0 1,1 1,2 
  When we tick to the next generation
  Then we have surviving cells at 0,0 1,0 0,2 1,2