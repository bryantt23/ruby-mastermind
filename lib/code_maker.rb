class CodeMaker
  def generate_secret_code
    4.times.map { ["R", "Y", "G", "B"].sample }.join("")
  end
end
