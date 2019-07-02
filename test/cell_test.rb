require './lib/cell/'
require './lib/ship/'
require 'minitest/autorun'
require 'minitest/pride'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_if_it_exists
    assert_instance_of Cell, @cell
  end

  def test_if_the_cell_has_a_coordinate
    assert_equal "B4", @cell.coordinate
  end

  def test_if_cell_default_is_no_ship
    assert_nil @cell.ship
    assert_equal true, @cell.empty?
  end

  def test_if_cell_returns_ship_placed_in_it
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end
end
