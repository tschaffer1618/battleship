class ComputerPlayer
  attr_reader :ships
  attr_accessor :computer_board
  def initialize
    @computer_board = nil
    @ships = [Ship.new("cruiser", 3), Ship.new("submarine", 2)]
  end

  def place_ships
    @ships.each do |ship|
      selected_coordinates = []
      until @computer_board.valid_placement?(ship, selected_coordinates)
        random_coord = @computer_board.cells.keys.sample
        possible_row = @computer_board.cells.keys.find_all do |key|
          random_coord[0] == key[0]
        end
        possible_column = @computer_board.cells.keys.find_all do |key|
          random_coord[1..2] == key[1..2]
        end
        selected_line = [possible_row, possible_column].sample
        possible_coordinates = selected_line.each_cons(ship.length).map { |group| group}
        selected_coordinates = possible_coordinates.sample
      end
      @computer_board.place(ship, selected_coordinates)
    end
    @computer_board
  end
end
