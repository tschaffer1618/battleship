require './lib/board'
require './lib/cell/'
require './lib/ship/'
require './lib/human_player/'
require './lib/computer_player/'
require './lib/game/'

loop do
  game = Game.new
  game.start_the_game
  game.create_a_ship
  game.pick_board_size
  game.play_the_game
  game.end_the_game
end
