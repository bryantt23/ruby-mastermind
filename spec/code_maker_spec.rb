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
  describe "#compare_guess_to_secret_code" do
    # Core examples from your doc

    it "returns 1 exact, 3 color for secret RGYB and guess RBGY" do
      maker = CodeMaker.new
      maker.secret_code = "RGYB"
      result = maker.compare_guess_to_secret_code("RBGY")
      expect(result).to eq({ exact_matches: 1, color_only_matches: 3 })
    end

    it "returns 2 exact, 2 color for secret RGYB and guess RGBY" do
      maker = CodeMaker.new
      maker.secret_code = "RGYB"
      result = maker.compare_guess_to_secret_code("RGBY")
      expect(result).to eq({ exact_matches: 2, color_only_matches: 2 })
    end

    it "returns 1 exact, 0 color for secret RGYB and guess BBBB" do
      maker = CodeMaker.new
      maker.secret_code = "RGYB"
      result = maker.compare_guess_to_secret_code("BBBB")
      expect(result).to eq({ exact_matches: 1, color_only_matches: 0 })
    end

    it "returns 1 exact, 0 color for secret RGYB and guess RRRR" do
      maker = CodeMaker.new
      maker.secret_code = "RGYB"
      result = maker.compare_guess_to_secret_code("RRRR")
      expect(result).to eq({ exact_matches: 1, color_only_matches: 0 })
    end

    it "returns 0 exact, 4 color for secret RGYB and guess GRBY" do
      maker = CodeMaker.new
      maker.secret_code = "RGYB"
      result = maker.compare_guess_to_secret_code("GRBY")
      expect(result).to eq({ exact_matches: 0, color_only_matches: 4 })
    end

    # Extra coverage for completeness

    it "returns 4 exact, 0 color for a perfect match" do
      maker = CodeMaker.new
      maker.secret_code = "RGYB"
      result = maker.compare_guess_to_secret_code("RGYB")
      expect(result).to eq({ exact_matches: 4, color_only_matches: 0 })
    end

    it "returns 0 exact, 0 color when no matches at all" do
      maker = CodeMaker.new
      maker.secret_code = "RGYB"
      result = maker.compare_guess_to_secret_code("CCCC")
      expect(result).to eq({ exact_matches: 0, color_only_matches: 0 })
    end

    it "correctly handles duplicates in secret" do
      maker = CodeMaker.new
      maker.secret_code = "RRGB"
      result = maker.compare_guess_to_secret_code("RRRR")
      expect(result).to eq({ exact_matches: 2, color_only_matches: 0 })
    end

    it "correctly handles duplicates in guess" do
      maker = CodeMaker.new
      maker.secret_code = "RRGB"
      result = maker.compare_guess_to_secret_code("BBRR")
      expect(result).to eq({ exact_matches: 0, color_only_matches: 3 })
    end
  end
end
