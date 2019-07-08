class HumanPlayer
  attr_reader :human_board, :ships
  def initialize
    @human_board = Board.new
    @ships = [Ship.new("cruiser", 3), Ship.new("submarine", 2)]
  end

  def place_ships
    puts "The computer ships have been placed. Now you can place yours!"
    puts @human_board.render
    puts "Please type your selections in this format: A1 A2 A3 "
    @ships.each do |ship|
      puts "Let's place the #{ship.name}."
      puts "The #{ship.name} is #{ship.length} tiles long."
      puts "In which tiles would you like to place the #{ship.name}?"
      print "> "
      user_selections = gets.chomp.upcase
      user_selections_array = user_selections.split(" ")
      until user_selections_array.all? { |coordinate| @human_board.valid_coordinate?(coordinate) } == true &&
        @human_board.valid_placement?(ship, user_selections_array) == true
        puts "Please choose valid tiles or exit the game by typing 'q' to quit."
        print "> "
        user_selections = gets.chomp.upcase
        if user_selections == "Q"
          exit!
        end
        user_selections_array = user_selections.split(" ")
      end
      puts "Good choice!"
      @human_board.place(ship, user_selections_array)
      puts @human_board.render(true)
    end
    puts "Let's start firing now!"
    @human_board
  end
end
