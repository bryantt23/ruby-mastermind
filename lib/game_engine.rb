require_relative "code_maker"
require_relative "view"

class GameEngine
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
    chances_remaining = 12

    # generate a secret code with CodeMaker
    secret_code = @code_maker.generate_secret_code
    @code_maker.secret_code = secret_code

    # show welcome message with View
    puts @view.show_welcome
    puts @view.show_actual_code(secret_code)

    # while chances_remaining > 0
    while chances_remaining > 0
      # show remaining chances with View
      puts @view.show_remaining_chances(chances_remaining)

      # get user guess (use gets.chomp.upcase)
      # compare guess with CodeMaker
      user_guess_result = player_move

      # if exact_matches == 4
      if user_guess_result[:exact_matches] == 4
        # show actual code with View
        puts @view.show_actual_code(secret_code)

        # show win message with View
        puts @view.show_win_loss(:win)
        # return early
        return
        # end
      end

      # show guess result with View
      @view.show_guess_result(user_guess_result)

      # decrement chances_remaining
      chances_remaining -= 1
      # end
    end

    # if loop ends without return, player lost
    # show loss message with View
    puts @view.show_win_loss(:loss)

    # show actual code with View
    puts @view.show_actual_code(secret_code)
  end

  private

  def play_again?
    puts @view.show_replay_prompt
    while user_input = gets.chomp
      case user_input
      when "X", "x"
        return false
      when ""
        return true
      else
        @view.show_replay_prompt
      end
    end
  end

  def player_move
    # validate guess (loop until valid)
    while true
      puts @view.prompt_for_guess
      user_input = gets.chomp.upcase
      have_valid_move = @code_maker.valid_user_guess?(user_input)
      if have_valid_move
        return @code_maker.compare_guess_to_secret_code(user_input)
      end
    end
  end
end

g = GameEngine.new
g.start_game
