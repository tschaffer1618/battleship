require './lib/ship/'


class Cell
  attr_reader :coordinate, :ship, :fired_upon
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    if ship == nil
      true
    else
      false
    end
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if @ship != nil
      @ship.health -= 1
    end
  end

  def render(show_ship = false)
    if show_ship == false
      if fired_upon? == false
        "."
      elsif fired_upon? == true && empty? == true
        "M"
      elsif fired_upon? == true && @ship.sunk? == false
        "H"
      else
        "X"
      end
    else
      if @ship != nil && fired_upon? == false
        "S"
      elsif fired_upon? == false
        "."
      elsif fired_upon? == true && empty? == true
        "M"
      elsif fired_upon? == true && @ship.sunk? == false
        "H"
      else
        "X"
      end
    end


  end


end
