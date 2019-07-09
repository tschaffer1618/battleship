require './lib/board'
require './lib/cell/'
require './lib/ship/'
require './lib/human_player/'
require 'minitest/autorun'
require 'minitest/pride'

class HumanPlayerTest < Minitest::Test
  def setup
    @human = HumanPlayer.new
    @human.human_board = Board.new
  end

  def test_if_it_exists
    assert_instance_of HumanPlayer, @human
  end

  def test_if_human_can_place_ships
    @human.place_ships
    cells_containing_ships = @human.human_board.cells.values.find_all {|cell| cell.empty? == false}
    cells_containing_cruiser = cells_containing_ships.find_all { |cell| cell.ship.name == "cruiser"}
    assert_equal 3, cells_containing_cruiser.length
    cells_containing_submarine = cells_containing_ships.find_all { |cell| cell.ship.name == "submarine"}
    assert_equal 2, cells_containing_submarine.length
  end
end
