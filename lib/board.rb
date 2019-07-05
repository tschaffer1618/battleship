class Board
  attr_reader :cells
  def initialize
    @cells = {
            "A1" => Cell.new("A1"),
            "A2" => Cell.new("A2"),
            "A3" => Cell.new("A3"),
            "A4" => Cell.new("A4"),
            "B1" => Cell.new("B1"),
            "B2" => Cell.new("B2"),
            "B3" => Cell.new("B3"),
            "B4" => Cell.new("B3"),
            "C1" => Cell.new("C1"),
            "C2" => Cell.new("C2"),
            "C3" => Cell.new("C3"),
            "C4" => Cell.new("C4"),
            "D1" => Cell.new("D1"),
            "D2" => Cell.new("D2"),
            "D3" => Cell.new("D3"),
            "D4" => Cell.new("D4")
            }
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, array_of_coordinates)
    cell_numbers = array_of_coordinates.map do |coordinate|
      coordinate.ord + coordinate[1].to_i
    end
    consecutive = cell_numbers.sort.each_cons(2).all?{|x,y| x ==y-1}
    letters = array_of_coordinates.map do |coordinate|
      coordinate[0]
    end
    numbers = array_of_coordinates.map do |coordinate|
      coordinate[1]
    end

    if ship.length != array_of_coordinates.length
      false
    elsif consecutive == false
      false
    elsif letters.uniq.length != 1 && numbers.uniq.length != 1
      false
    else
      true 
    end

  end
end
