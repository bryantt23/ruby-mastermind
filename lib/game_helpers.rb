module GameHelpers
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
end
