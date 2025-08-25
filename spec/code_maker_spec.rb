# spec/code_maker_spec.rb
require "code_maker"

RSpec.describe CodeMaker do
  describe "#generate_secret_code" do
    it "returns a string of length 4" do
      maker = CodeMaker.new
      code = maker.generate_secret_code
      expect(code.length).to eq(4)
    end

    it "returns only characters from R, G, Y, B" do
      maker = CodeMaker.new
      code = maker.generate_secret_code
      expect(code).to match(/\A[RGYB]{4}\z/)
    end

    it "can contain duplicates" do
      maker = CodeMaker.new
      codes = Array.new(100) { maker.generate_secret_code }
      has_duplicate = codes.any? { |code| code.chars.uniq.length < 4 }

      expect(has_duplicate).to be true
    end
  end
end
