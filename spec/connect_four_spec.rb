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
  end
end