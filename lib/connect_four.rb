class ConnectFour
  attr_reader :grid

  def initialize
    generate_empty_grid
  end

  private

  # Generates an empty grid of size 6 x 7, with coordinates (y, x)
  # where y is the column number, x is the row number from the bottom
  def generate_empty_grid
    @grid = Array.new(7) { [nil] * 6 }
  end 
end