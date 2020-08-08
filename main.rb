require_relative 'lib/console_input'
require_relative 'lib/connect_four'

connect_four = ConnectFour.new

def validate_column_num(input, valid_columns)
  raise "Input is not a number!" unless input =~ /^-?[0-9]+$/
  raise "Out of range!" unless (1..7).include?(input.to_i)

  raise "Column selected is full!" unless valid_columns.include?(input.to_i - 1)

  input.to_i
end

puts "    ----    Connect Four    ----    \n"\
     " -- How to play : \n"\
     "\> Each player is prompted about which column the player wishes to \n"\
     "  place his/her chip.\n"\
     "\> The player must enter the column number when prompted.\n"\
     "\> The goal is to be the first one to get 4 of their chips in a row \n"\
     "  (diagonals count)\n\n"

# Start with random player
current_player = [1, 2].sample
result = -1

# Game loop which ends when evalute does not return -1
while result == -1
  print "\n"
  print connect_four.show_grid('a', 'b', true)

  # Prompt for player input
  print "Player #{current_player}'s turn : "
  col = Input.get_valid_input(lambda { |x| validate_column_num(x, connect_four.valid_columns) })

  connect_four.insert(current_player, col - 1)

  # Change player after each loop
  current_player = (current_player == 1 ? 2 : 1)
  result = connect_four.evaluate
end

puts result