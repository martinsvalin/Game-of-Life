require './lib/neighbourhood'

describe "Neighbourhood" do
  describe "cells_around" do
    it "should find the correct neighbours for 5,5" do
      Neighbourhood.cells_around(5,5).should =~ 
      [
        [4,4], [4,5], [4,6],
        [5,4],        [5,6],
        [6,4], [6,5], [6,6]
      ]  
    end

    it "should find the correct neighbours for 8,2" do
      Neighbourhood.cells_around(8,2).should =~ 
      [
        [7,1], [7,2], [7,3],
        [8,1],        [8,3],
        [9,1], [9,2], [9,3]
      ]  
    end
  end
end