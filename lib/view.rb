class View
  def show_welcome
    "Welcome to Code Breaker!"
  end

  def show_remaining_chances(chances_left)
    "You have #{chances_left} chances left..."
  end

  def show_guess_result(guess_result)
    "You have #{guess_result[:exact_matches]} exact match(es), #{guess_result[:color_only_matches]} color match(es)"
  end

  def show_win_loss(result)
    result == :win ? "You are a Master Code Breaker!" : "You are broken by the code :("
  end

  def show_actual_code(actual_code)
    "The code was #{actual_code}"
  end

  def show_replay_prompt
    "Press Enter to play again or X to exit"
  end

  def prompt_for_guess
    "Enter your guess"
  end

  def prompt_for_secret_code
    "Enter a 4-letter code using only R, G, Y, or B:"
  end

  def computer_guess
    "Computer guess is "
  end
end
