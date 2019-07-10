class Board
  attr_reader :cells, :letters, :numbers
  attr_accessor :size
  def initialize(size = 4)
    @size = size
    @letters = ("A".."Z").first(@size).to_a
    @numbers = (1..26).first(@size).to_a
    @cells = make_cells_hash
  end

  def coordinates_by_row
    @letters.map { |row| @numbers.map { |column| "#{row}#{column}" } }
  end

  def all_coordinates
    coordinates_by_row.flatten
  end

  def make_cells_hash
    @cells = {}
    all_coordinates.map do |coord|
      @cells[coord] = Cell.new(coord)
    end
    @cells
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def consecutive?(array_of_coordinates)
    cell_numbers = array_of_coordinates.map do |coordinate|
      coordinate.ord + coordinate[1..2].to_i
    end
    cell_numbers.sort.each_cons(2).all? { |x, y| x == y - 1 }
  end

  def linear?(array_of_coordinates)
    numbers = array_of_coordinates.map { |coordinate| coordinate[1..2] }
    letters = array_of_coordinates.map { |coordinate| coordinate[0] }
    letters.uniq.length == 1 || numbers.uniq.length == 1
  end

  def unoccupied?(array_of_coordinates)
    cell_contents = array_of_coordinates.map do |coordinate|
      @cells[coordinate].ship.class
    end
    !cell_contents.include?(Ship)
  end

  def valid_placement?(ship, array_of_coordinates)
    if ship.length != array_of_coordinates.length
      false
    elsif !consecutive?(array_of_coordinates)
      false
    elsif !linear?(array_of_coordinates)
      false
    elsif !unoccupied?(array_of_coordinates)
      false
    else
      true
    end
  end

  def place(ship, array_of_coordinates)
    array_of_coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def first_line
    if @size <= 9
      "  " + @numbers.join(" ") + " \n"
    else
      "  " + @numbers.first(9).join(" ") + @numbers[9..25].join("") + " \n"
    end 
  end

  def other_lines(rows)
    zipped = @letters.zip(rows)
    rows_regrouped = zipped.flatten.each_slice(@size + 1).map { |group| group }
    display = rows_regrouped.map { |row| row.join(" ") + " \n" }
    display.join("")
  end

  def render(show_ship = false)
    if show_ship == false
      rows = coordinates_by_row.map { |row| row.map { |coord| @cells[coord].render} }
      first_line + other_lines(rows)
    else
      rows = coordinates_by_row.map { |row| row.map { |coord| @cells[coord].render(true)} }
      first_line + other_lines(rows)
    end
  end
end
