class HumanPlayer
  attr_reader :ships
  attr_accessor :human_board
  def initialize
    @human_board = nil
    @ships = [Ship.new("cruiser", 3), Ship.new("submarine", 2)]
  end

  def valid_coordinates?(ship, array_of_coordinates)
    array_of_coordinates.all? { |coordinate| @human_board.valid_coordinate?(coordinate) } &&
      @human_board.valid_placement?(ship, array_of_coordinates)
  end

  def place_ships
    puts "The computer ships have been placed. Now you can place yours!"
    puts @human_board.render
    puts "Please type your selections in this format: A1 A2 A3 "
    @ships.each do |ship|
      puts "Let's place the #{ship.name}."
      puts "The #{ship.name} is #{ship.length} tiles long."
      puts "In which tiles would you like to place the #{ship.name}?"
      array_of_coordinates = []
      until valid_coordinates?(ship, array_of_coordinates)
        puts "Please choose valid tiles or exit the game by typing 'q'."
        print "> "
        user_selections = gets.chomp.upcase
        exit! if user_selections == "Q"
        array_of_coordinates = user_selections.split(" ")
      end
      puts "Good choice!"
      @human_board.place(ship, array_of_coordinates)
      puts "====== Player Board ======"
      puts @human_board.render(true)
    end
    puts "Let's start firing now!"
    @human_board
  end
end
