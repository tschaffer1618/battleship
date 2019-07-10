class Game
  attr_reader :cpu, :human
  def initialize
    @cpu = ComputerPlayer.new
    @human = HumanPlayer.new
  end

  def start_the_game
    puts "**** Welcome to BATTLESHIP! ****"
    user_input = ""
    until user_input == "p" || user_input == "q"
      puts "Enter 'p' to play or 'q' to quit."
      print "> "
      user_input = gets.chomp.downcase
      if user_input == "p"
        puts "Let's begin!"
      elsif user_input == "q"
        puts "See you next time!"
        exit!
      else
        puts "Invalid response."
      end
    end
  end

  def create_a_ship
    puts "You have a cruiser that is 3 tiles long and a submarine that is 2 tiles long."
    response = "yes"
    until response == "no"
      puts "Would you like to play with additional ships?"
      puts "Enter 'yes' or 'no'."
      print "> "
      response = gets.chomp.downcase
      if response == "no"
        break
      elsif response == "yes"
        puts "What is the name of the ship?"
        print "> "
        ship = gets.chomp.downcase
        length = 0
        until length >= 2 && length <= 6
          puts "How many tiles long is the #{ship}? Choose a number from 2 to 6."
          print "> "
          length = gets.chomp.to_i
        end
        cpu_new_ship = Ship.new(ship, length)
        human_new_ship = Ship.new(ship, length)
        @cpu.ships << cpu_new_ship
        @human.ships << human_new_ship
        puts "Great! You created the #{ship} that is #{length} tiles long."
      else
        puts "Type 'yes' to make a new ship or 'no' to continue the game."
      end
    end
    puts "You are playing with #{@cpu.ships.length} ships!"
  end

  def valid_board_size?(size)
    longest_ship = @human.ships.max_by { |ship| ship.length }
    size >= longest_ship.length && size <= 26
  end

  def pick_board_size
    size = 0
    puts "How many rows and columns would you like on your board?"
    puts "If you are playing with 2 ships, we recommend 4."
    puts "If you are playing with 3 ships, we recommend 6."
    puts "If you are playing with 4 ships, we recommend 8."
    puts "You get the idea! Just multiply the number of ships by 2!"
    until valid_board_size?(size)
      print "> "
      size = gets.chomp.to_i
      if !valid_board_size?(size)
        puts "That size doesn't work! Try again."
      end
    end
    @cpu.computer_board = Board.new(size)
    @human.human_board = Board.new(size)
  end

  def show_boards
    puts "===== Computer Board ===== "
    puts @cpu.computer_board.render
    puts "====== Player Board ======"
    puts @human.human_board.render(true)
  end

 def human_turn
    puts "Enter the coordinate for your shot."
    print "> "
    guessed_coordinate = gets.chomp.upcase
    until @cpu.computer_board.valid_coordinate?(guessed_coordinate) == true &&
      @cpu.computer_board.cells[guessed_coordinate].fired_upon? == false
      if @cpu.computer_board.valid_coordinate?(guessed_coordinate) == false
        puts "Please choose a valid coordinate."
      elsif @cpu.computer_board.cells[guessed_coordinate].fired_upon? == true
        puts "You have already fired on that spot. Please choose another coordinate."
      end
      print "> "
      guessed_coordinate = gets.chomp.upcase
    end
    @cpu.computer_board.cells[guessed_coordinate].fire_upon
    if @cpu.computer_board.cells[guessed_coordinate].render == "M"
      puts "Your shot on #{guessed_coordinate} was a miss!"
    elsif @cpu.computer_board.cells[guessed_coordinate].render == "H"
      puts "You hit the #{@cpu.computer_board.cells[guessed_coordinate].ship.name} at #{guessed_coordinate}!"
    else
      puts "You sank the #{@cpu.computer_board.cells[guessed_coordinate].ship.name}!"
    end
    @cpu.computer_board
  end

  def computer_turn
    guessed_coordinate = @human.human_board.cells.keys.sample
    until @human.human_board.valid_coordinate?(guessed_coordinate) == true && @human.human_board.cells[guessed_coordinate].fired_upon? == false
      guessed_coordinate = @human.human_board.cells.keys.sample
    end
    @human.human_board.cells[guessed_coordinate].fire_upon
    if @human.human_board.cells[guessed_coordinate].render == "M"
      puts "The computer shot on #{guessed_coordinate} was a miss!"
    elsif @human.human_board.cells[guessed_coordinate].render == "H"
      puts "The computer hit your #{@human.human_board.cells[guessed_coordinate].ship.name} at #{guessed_coordinate}!"
    else
      puts "The computer sank your #{@human.human_board.cells[guessed_coordinate].ship.name}!"
    end
    @human.human_board
  end

  def take_turn
    show_boards
    human_turn
    computer_turn
  end

  def play_the_game
    @cpu.place_ships
    @human.place_ships
    until @human.ships.all? { |ship| ship.sunk? } || @cpu.ships.all? { |ship| ship.sunk? }
      take_turn
    end
  end

  def end_the_game
    show_boards
    if @human.ships.all? { |ship| ship.sunk? }
      puts "You lost! Better luck next time!"
    else
      puts "You are victorious! Great job!"
    end
  end
end
