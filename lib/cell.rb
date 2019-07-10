class Cell
  attr_reader :coordinate, :ship, :fired_upon
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil ? true : false
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    @ship.health -= 1 if @ship != nil
  end

  def render(show_ship = false)
    if show_ship == false
      if !fired_upon?
        "."
      elsif fired_upon? && empty?
        "M"
      elsif fired_upon? && !@ship.sunk?
        "H"
      else
        "X"
      end
    else
      if !empty? && !fired_upon?
        "S"
      elsif !fired_upon?
        "."
      elsif fired_upon? && empty?
        "M"
      elsif fired_upon? && !@ship.sunk?
        "H"
      else
        "X"
      end
    end
  end
end
