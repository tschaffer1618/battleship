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
end
