require './lib/board'
require './lib/cell/'
require './lib/ship/'
require 'minitest/autorun'
require 'minitest/pride'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
  end

  def test_board_exists
    assert_instance_of Board, @board
  end

  def test_cells
    assert_equal 16, @board.cells.length
    assert_equal Hash, @board.cells.class
    assert_equal Cell, @board.cells['A1'].class
  end

  def test_if_cell_coordinates_are_valid
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

end
