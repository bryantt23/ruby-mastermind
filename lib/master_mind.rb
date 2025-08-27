require_relative "computer_game_engine"
require_relative "game_engine"
require_relative "view"

class MasterMind
  def initialize
    @view = View.new
  end

  def start_game

    # set keep_playing = true
    keep_playing = true

    # while keep_playing
    while keep_playing != :exit
      # ask if the player wants to keep playing (y/n) and which
      # update keep_playing based on response
      keep_playing = play_again?
      if keep_playing == :you_guess
        GameEngine.new.start_game
      elsif keep_playing == :computer_guesses
        ComputerGameEngine.new.start_game
      end
      # end
    end
  end

  private

  def play_again?
    puts @view.prompt_for_game
    while user_input = gets.chomp
      case user_input
      when "1"
        return :you_guess
      when "2"
        return :computer_guesses
      when "X", "x"
        return :exit
      else
        puts @view.prompt_for_game
      end
    end
  end
end

m = MasterMind.new
m.start_game
