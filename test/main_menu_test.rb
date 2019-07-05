require './lib/main_menu'
require 'minitest/autorun'
require 'minitest/pride'

class MainMenuTest < Minitest::Test
  def test_it_exists
    menu = MainMenu.new
    assert_instance_of MainMenu, menu
  end

  def test_if_proper_strings_are_returned
    menu = MainMenu.new
    assert_equal "Let's begin", menu.display_menu
  end 
end
