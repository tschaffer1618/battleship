require './lib/ship/'
require 'minitest/autorun'
require 'minitest/pride'

class ShipTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_if_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
  end

  def test_what_is_initial_health
    assert_equal 3, @cruiser.health
  end

  def test_if_it_is_initially_sunk
    assert_equal false, @cruiser.sunk?
  end

  def test_if_cruiser_loses_health_on_being_hit
    @cruiser.hit
    assert_equal 2, @cruiser.health
    @cruiser.hit
    @cruiser.hit
    assert_equal 0, @cruiser.health
  end

  def test_if_cruiser_has_sunk
    @cruiser.hit
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    @cruiser.hit
    assert_equal true, @cruiser.sunk?
  end
end
