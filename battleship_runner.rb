require './lib/board'
require './lib/cell/'
require './lib/ship/'
require './lib/human_player/'
require './lib/computer_player/'
require './lib/game/'

game = Game.new

game.start_the_game
game.cpu.place_ships
game.human.place_ships

until game.human.ships.all? { |ship| ship.sunk? } || game.cpu.ships.all? { |ship| ship.sunk? }
 game.take_turn
end

game.end_the_game
