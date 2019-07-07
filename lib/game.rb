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
      puts "You sunk the #{@cpu.computer_board.cells[guessed_coordinate].ship.name}!"
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
      puts "The computer sunk your #{@human.human_board.cells[guessed_coordinate].ship.name}!"
    end
    @human.human_board
  end

  def take_turn
    show_boards
    human_turn
    computer_turn
  end

  def end_the_game
    show_boards
    if @human.ships.all? { |ship| ship.sunk? }
      puts "You lost! Better luck next time!"
    else
      puts "You are victorious! Great job!"
    end
    start_the_game
  end

  end
