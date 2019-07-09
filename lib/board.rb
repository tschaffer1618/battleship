class Board
  attr_reader :cells, :letters, :numbers
  attr_accessor :size
  def initialize(size = 4)
    @size = size
    @letters = ("A".."Z").first(@size).to_a
    @numbers = (1..26).first(@size).to_a
    @cells = make_cells_hash
  end

  def make_cells_hash
    @cells = {}
    coords_by_row = @letters.map { |row| @numbers.map { |column| "#{row}#{column}" } }
    all_coords = coords_by_row.flatten
    all_coords.map do |coord|
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
    numbers = array_of_coordinates.map do |coordinate|
      coordinate[1..2]
    end
    letters = array_of_coordinates.map do |coordinate|
      coordinate[0]
    end
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
    elsif consecutive?(array_of_coordinates) == false
      false
    elsif linear?(array_of_coordinates) == false
      false
    elsif unoccupied?(array_of_coordinates) == false
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

  def render(show_ship = false)
    if show_ship == false
      first_line = "  " + @numbers.join(" ") + " \n"
      coords_by_row = @letters.map { |row| @numbers.map { |column| "#{row}#{column}" } }
      rows_1 = coords_by_row.map { |row| row.map { |coord| @cells[coord].render} }
      zipped = @letters.zip(rows_1)
      rows_2 = zipped.flatten.each_slice(@size + 1).map { |group| group }
      display = rows_2.map { |row| row.join(" ") + " \n" }
      first_line + display.join("")
    elsif show_ship == true
      first_line = "  " + @numbers.join(" ") + " \n"
      coords_by_row = @letters.map { |row| @numbers.map { |column| "#{row}#{column}" } }
      rows_1 = coords_by_row.map { |row| row.map { |coord| @cells[coord].render(true)} }
      zipped = @letters.zip(rows_1)
      rows_2 = zipped.flatten.each_slice(@size + 1).map { |group| group }
      display = rows_2.map { |row| row.join(" ") + " \n" }
      first_line + display.join("")
    end
  end
end
