class CodeMaker
  attr_accessor :secret_code

  def initialize
    @secret_code = generate_secret_code
  end

  def generate_secret_code
    4.times.map { ["R", "Y", "G", "B"].sample }.join("")
  end

  def compare_guess_to_secret_code(guessed_code)
    secret_code_arr = secret_code.split("")
    exact_matches = 0

    secret_code_arr.each_with_index do |element, index|
      if element == guessed_code[index]
        exact_matches += 1
        secret_code_arr[index] = "X"
      end
    end

    freq = Hash.new(0)

    secret_code_arr.each do |element|
      freq[element] += 1
    end

    color_only_matches = 0

    guessed_code.split("").each do |character|
      if freq.has_key?(character) && freq[character] > 0
        color_only_matches += 1
        freq[character] -= 1
      end
    end

    { exact_matches:, color_only_matches: }
  end

  def valid_user_guess?(user_guess)
    (/\A[RGYB]{4}\z/).match?(user_guess.upcase)
  end
end
