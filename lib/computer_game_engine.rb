require_relative "code_maker"
require_relative "view"

class ComputerGameEngine
  MAX_CHANCES = 12

  def initialize
    @view = View.new
    @code_maker = CodeMaker.new
  end

  def start_game

    # set keep_playing = true
    keep_playing = true

    # while keep_playing
    while keep_playing
      # call play_game
      play_game

      # ask if the player wants to keep playing (y/n)
      # update keep_playing based on response
      keep_playing = play_again?
      # end
    end
  end

  def play_game
    # initialize chances_remaining = 12
    chances_remaining = MAX_CHANCES

    # show welcome message with View
    puts @view.show_welcome

    # generate a secret code with CodeMaker and by asking player
    player_generate_secret_code

    # while chances_remaining > 0
    while chances_remaining > 0
      # show remaining chances with View
      puts @view.show_remaining_chances(chances_remaining)

      # get computer guess
      # compare guess with CodeMaker
      computer_guess_result = computer_move

      # show guess result with View
      puts @view.show_guess_result(computer_guess_result)

      # if exact_matches == 4
      if computer_guess_result[:exact_matches] == 4
        # show actual code with View
        puts @view.show_actual_code(@code_maker.secret_code)

        # show win message with View
        puts @view.show_win_loss(:win)
        # return early
        return
        # end
      end

      # decrement chances_remaining
      chances_remaining -= 1
      # end
    end

    # if loop ends without return, player lost
    # show loss message with View
    puts @view.show_win_loss(:loss)

    # show actual code with View
    puts @view.show_actual_code(@code_maker.secret_code)
  end

  private

  def player_generate_secret_code
    player_secret_code_is_valid = false
    while player_secret_code_is_valid != true
      puts @view.prompt_for_secret_code
      user_input = gets.chomp.upcase
      player_secret_code_is_valid = @code_maker.valid_user_guess?(user_input)
    end
    @code_maker.secret_code = user_input
  end

  def play_again?
    puts @view.show_replay_prompt
    while user_input = gets.chomp
      case user_input
      when "X", "x"
        return false
      when ""
        return true
      else
        puts @view.show_replay_prompt
      end
    end
  end

  def computer_move
    computer_guess = @code_maker.generate_secret_code
    puts "#{@view.computer_guess} #{computer_guess}"
    @code_maker.compare_guess_to_secret_code(computer_guess)
  end
end
