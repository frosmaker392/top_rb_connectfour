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
end