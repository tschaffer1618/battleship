require './lib/board'
require './lib/cell/'
require './lib/ship/'
require './lib/computer_player/'
require 'minitest/autorun'
require 'minitest/pride'

class ComputerPlayerTest < Minitest::Test
  def setup
    @cpu = ComputerPlayer.new
    @cpu.computer_board = Board.new
  end

  def test_if_it_exists
    assert_instance_of ComputerPlayer, @cpu
  end

  def test_if_computer_can_place_ships
    @cpu.place_ships
    cells_containing_ships = @cpu.computer_board.cells.values.find_all {|cell| cell.empty? == false}
    cells_containing_cruiser = cells_containing_ships.find_all { |cell| cell.ship.name == "cruiser"}
    assert_equal 3, cells_containing_cruiser.length
    cells_containing_submarine = cells_containing_ships.find_all { |cell| cell.ship.name == "submarine"}
    assert_equal 2, cells_containing_submarine.length
  end
end
