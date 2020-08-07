class ConnectFour
  attr_reader :grid
  attr_reader :valid_columns

  def initialize
    generate_empty_grid
    @valid_columns = Array.new(7) { |x| x }
  end

  public

  # Changes the first nil value of the array at column into num
  def insert(num, column)
    @grid[column].each_with_index do |pos, index|
      next unless pos.nil?

      @valid_columns.delete(column) if index == 5
      @grid[column][index] = num
      return
    end
  end

  def insert_arr(arr, column)
    arr.each do |num|
      insert(num, column)
    end
  end
  
  # Returns the number if there is a 4-in-a-row of that number,
  # else returns 0 if none are found but grid is full,
  # else returns -1 (continue)
  def evaluate
    @grid.each_with_index do |col_arr, col|
      col_arr.each_index do |row|
        hor = is_horizontal_four?(col, row)
        ver = is_vertical_four?(col, row)
        up_diag = is_upper_diagonal_four?(col, row)
        lo_diag = is_lower_diagonal_four?(col, row)

        return @grid[col][row] if hor || ver || up_diag || lo_diag
      end
    end

    return 0 if valid_columns.empty?
    return -1
  end

  # Returns a string which shows the whole grid like the actual connect 4 game, 
  # can replace 1 and 2 with custom characters, and show the number row
  def show_grid(replace_1 = nil, replace_2 = nil, show_column_num = false)
    out = ""
    6.times do |x|
      x = 5 - x
      7.times do |y|
        grid_el = @grid[y][x]

        if grid_el == 1 then out << (replace_1.nil? ? '1' : replace_1)
        elsif grid_el == 2 then out << (replace_2.nil? ? '2' : replace_2)
        else out << ' ' end

        out << ' ' unless y == 6
      end

      out << "\n"
    end

    out << "\n1 2 3 4 5 6 7\n" if show_column_num
    out
  end

  private

  # Generates an empty grid of size 6 x 7, with coordinates (y, x)
  # where y is the column number, x is the row number from the bottom
  def generate_empty_grid
    @grid = Array.new(7) { [nil] * 6 }
  end

  # Checks if 4 elements at the right of @grid[col][row] are the same
  def is_horizontal_four?(col, row)
    return false if @grid[col][row].nil? || col > 3
    
    check_if_4inarow(col, row, 1, 0)
  end

  # Checks if 4 elements above @grid[col][row] are the same
  def is_vertical_four?(col, row)
    return false if @grid[col][row].nil? || row > 2

    check_if_4inarow(col, row, 0, 1)
  end

  # Checks if 4 elements in an upper diagonal from @grid[col][row] are the same
  def is_upper_diagonal_four?(col, row)
    return false if @grid[col][row].nil? || col > 3 || row > 2

    check_if_4inarow(col, row, 1, 1)
  end

  # Checks if 4 elements in an lower diagonal from @grid[col][row] are the same
  def is_lower_diagonal_four?(col, row)
    return false if @grid[col][row].nil? || col > 3 || row < 3

    check_if_4inarow(col, row, 1, -1)
  end

  # Move by (x_offset, y_offset) from (x,y) in grid and checks if all 
  # 4 numbers at those positions are equal
  def check_if_4inarow(y, x, y_offset, x_offset)
    num = @grid[y][x]
    3.times do |i|
      num_to_compare = @grid[y + (i + 1) * y_offset][x + (i + 1) * x_offset]
      return false if num_to_compare.nil? || num_to_compare != num
    end

    true
  end
end