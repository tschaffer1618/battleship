require './lib/board'
require './lib/cell/'
require './lib/ship/'
require 'minitest/autorun'
require 'minitest/pride'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_board_exists
    assert_instance_of Board, @board
  end

  def test_cells
    assert_equal 16, @board.cells.length
    assert_equal Hash, @board.cells.class
    assert_equal Cell, @board.cells["A1"].class
  end

  def test_if_cell_coordinates_are_valid
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_placement_for_length
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  end

  def test_placement_is_consecutive
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
  end

  def test_it_is_not_diagnol
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "C1"])
    assert_equal false, @board.valid_placement?(@submarine, ["B4", "D3"])
  end

  def test_if_is_valid_placement
    assert_equal true, @board.valid_placement?(@cruiser, ["B2", "B3", "B4"])
    assert_equal true, @board.valid_placement?(@submarine, ["D1", "C1"])
  end


end
