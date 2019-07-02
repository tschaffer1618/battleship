require './lib/cell/'
require './lib/ship/'
require 'minitest/autorun'
require 'minitest/pride'

class CellTest < Minitest::Test
  def setup
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_if_it_exists
    assert_instance_of Cell, @cell_1
  end

  def test_if_the_cell_has_a_coordinate
    assert_equal "B4", @cell_1.coordinate
  end

  def test_if_cell_default_is_no_ship
    assert_nil @cell_1.ship
    assert_equal true, @cell_1.empty?
  end

  def test_if_cell_returns_ship_placed_in_it
    @cell_1.place_ship(@cruiser)
    assert_equal @cruiser, @cell_1.ship
    assert_equal false, @cell_1.empty?
  end

  def test_if_fired_upon
    assert_equal false, @cell_1.fired_upon?
    @cell_1.fire_upon
    assert_equal true, @cell_1.fired_upon?
  end

  def test_if_fired_upon_ship_looses_health
    @cell_1.place_ship(@cruiser)
    @cell_1.fire_upon
    assert_equal 2, @cell_1.ship.health
  end

  def test_render_default
    assert_equal ".", @cell_1.render
    assert_equal ".", @cell_2.render
  end

  def test_render_if_cell_is_empty_when_fired_upon
    @cell_1.fire_upon
    assert_equal true, @cell_1.empty?
    assert_equal "M", @cell_1.render
  end

  def test_render_if_cell_has_a_ship_when_fired_upon
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon
    assert_equal false, @cell_2.empty?
    assert_equal false, @cell_2.ship.sunk?
    assert_equal "H", @cell_2.render
  end

  def test_render_if_cell_has_a_ship_that_sinks_when_fired_upon
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon
    @cell_2.ship.hit
    @cell_2.ship.hit
    assert_equal true, @cell_2.ship.sunk?
    assert_equal "X", @cell_2.render
  end

  def test_render_true_to_show_ships
    assert_equal ".", @cell_1.render(true)
    @cell_2.place_ship(@cruiser)
    assert_equal "S", @cell_2.render(true)
  end


end
