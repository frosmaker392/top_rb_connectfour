require './lib/connect_four'

describe ConnectFour do
  describe "#initialize" do 
    it "initializes an empty grid with the correct dimensions (6 x 7)" do
      c4 = ConnectFour.new
      expect(c4.grid).to eql([[nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil]])
    end
  end

  describe "#insert" do
    it "inserts a number into the correct columns in the grid" do
      c4 = ConnectFour.new
      c4.insert(1, 0)
      c4.insert(1, 1)
      c4.insert(1, 2)
      expect(c4.grid).to eql([[1, nil, nil, nil, nil, nil], 
                              [1, nil, nil, nil, nil, nil],
                              [1, nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil]])
    end

    it "stacks a number on top of each other instead of replacing the number" do
      c4 = ConnectFour.new
      c4.insert(1, 3)
      c4.insert(1, 3)
      c4.insert(1, 3)
      expect(c4.grid).to eql([[nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, nil, nil],
                              [1, 1, 1, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil]])
    end

    it "does not exceed the length of the array" do
      c4 = ConnectFour.new
      8.times { c4.insert(1, 3) }
      expect(c4.grid).to eql([[nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, nil, nil],
                              [1, 1, 1, 1, 1, 1], 
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil]])
    end

    it "inserts different numbers" do
      c4 = ConnectFour.new
      4.times { c4.insert(1, 6); c4.insert(2, 6) }
      c4.insert(1, 5)
      c4.insert(2, 4)
      c4.insert(1, 4)
      c4.insert(2, 1)
      expect(c4.grid).to eql([[nil, nil, nil, nil, nil, nil], 
                              [2, nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, nil, nil], 
                              [2, 1, nil, nil, nil, nil], 
                              [1, nil, nil, nil, nil, nil], 
                              [1, 2, 1, 2, 1, 2]])
    end
    
    it "ensures that the column is deleted from @valid_columns once full" do
      c4 = ConnectFour.new
      6.times { c4.insert(1, 4) }
      expect(c4.valid_columns).to eql([0, 1, 2, 3, 5, 6])
    end
  end

  describe "#insert_arr" do
    it "inserts an array into a column (for testing purposes)" do
      c4 = ConnectFour.new
      c4.insert_arr([1,1,1,1], 3)
      expect(c4.grid).to eql([[nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, nil, nil],
                              [1, 1, 1, 1, nil, nil], 
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil]])
    end

    it "only inserts up to when the column is full" do
      c4 = ConnectFour.new
      c4.insert(2, 2)
      c4.insert(1, 2)
      c4.insert_arr([1,1,1,2,1,2], 2)
      expect(c4.grid).to eql([[nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil],
                              [2, 1, 1, 1, 1, 2],
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil], 
                              [nil, nil, nil, nil, nil, nil]])
    end
  end

  describe "#evaluate" do
    it "finds 4 numbers in a horizontal row and returns the number" do
      c4 = ConnectFour.new
      c4.insert(1, 1)
      c4.insert(1, 2)
      c4.insert(1, 3)
      c4.insert(1, 4)
      expect(c4.evaluate).to eql(1)
    end

    it "finds 4 numbers in a vertical row and returns the number" do
      c4 = ConnectFour.new
      4.times { c4.insert(2, 1) }
      expect(c4.evaluate).to eql(2)
    end

    it "finds 4 numbers in a upper diagonal row and returns the number" do
      c4 = ConnectFour.new
      c4.insert(1, 1)
      c4.insert(2, 2)
      c4.insert(1, 2)
      c4.insert(2, 3)
      c4.insert(2, 3)
      c4.insert(1, 3)
      c4.insert(2, 4)
      c4.insert(2, 4)
      c4.insert(2, 4)
      c4.insert(1, 4)
      expect(c4.evaluate).to eql(1)
    end

    it "finds 4 numbers in a lower diagonal row and returns the number" do
      c4 = ConnectFour.new
      c4.insert(1, 3)
      c4.insert(1, 3)
      c4.insert(1, 3)
      c4.insert(2, 3)
      c4.insert(1, 4)
      c4.insert(1, 4)
      c4.insert(2, 4)
      c4.insert(1, 5)
      c4.insert(2, 5)
      c4.insert(2, 6)
      expect(c4.evaluate).to eql(2)
    end

    it "returns -1 (continue) if no 4-in-a-rows are found" do
      c4 = ConnectFour.new
      c4.insert(1, 0)
      c4.insert(1, 1)
      c4.insert(1, 2)
      c4.insert(2, 3)
      c4.insert(1, 3)
      c4.insert(2, 6)
      expect(c4.evaluate).to eql(-1)
    end

    it "returns -1 for an empty grid" do
      c4 = ConnectFour.new
      expect(c4.evaluate).to eql(-1)
    end

    it "returns 0 for a draw (no 4-in-a-rows)" do
      c4 = ConnectFour.new
      c4.insert_arr([1, 1, 2, 1, 2, 1], 0)
      c4.insert_arr([1, 1, 2, 1, 2, 1], 1)
      c4.insert_arr([2, 2, 1, 2, 2, 1], 2)
      c4.insert_arr([2, 2, 1, 2, 1, 2], 3)
      c4.insert_arr([1, 1, 2, 2, 2, 1], 4)
      c4.insert_arr([2, 1, 2, 1, 2, 1], 5)
      c4.insert_arr([1, 2, 1, 2, 2, 1], 6)
      expect(c4.evaluate).to eql(0)
    end
  end

  describe "#show_grid" do
    it "returns a string that shows the grid in a presentable manner" do
      c4 = ConnectFour.new
      c4.insert(1, 1)
      c4.insert_arr([1, 2, 1], 2)
      c4.insert(2, 3)
      c4.insert_arr([1, 1, 2, 2], 5)
      expect(c4.show_grid).to eql("┌─────────────┐\n"\
                                  "│             │\n"\
                                  "│             │\n"\
                                  "│          2  │\n"\
                                  "│    1     2  │\n"\
                                  "│    2     1  │\n"\
                                  "│  1 1 2   1  │\n"\
                                  "└─────────────┘\n")
    end

    it "replaces 1 and 2 with custom characters if specified in the params" do
      c4 = ConnectFour.new
      c4.insert(2, 0)
      c4.insert_arr([1, 1, 2, 2, 1], 1)
      c4.insert_arr([1, 2, 1], 2)
      c4.insert_arr([2, 2, 2, 1], 3)
      c4.insert_arr([1, 1, 1, 2], 4)
      expect(c4.show_grid('A', 'B')).to eql("┌─────────────┐\n"\
                                            "│             │\n"\
                                            "│  A          │\n"\
                                            "│  B   A B    │\n"\
                                            "│  B A B A    │\n"\
                                            "│  A B B A    │\n"\
                                            "│B A A B A    │\n"\
                                            "└─────────────┘\n")
    end

    it "writes the column numbers below the grid when show_column_num is true" do
      c4 = ConnectFour.new
      expect(c4.show_grid('a', 'b', true)).to eql("┌─────────────┐\n"\
                                                  "│             │\n"\
                                                  "│             │\n"\
                                                  "│             │\n"\
                                                  "│             │\n"\
                                                  "│             │\n"\
                                                  "│             │\n"\
                                                  "└─────────────┘\n"\
                                                  " 1 2 3 4 5 6 7\n")
    end
  end
end