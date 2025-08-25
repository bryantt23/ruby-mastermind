# spec/code_maker_spec.rb
require "code_maker"

RSpec.describe CodeMaker do
  before do
    @maker = CodeMaker.new
  end

  describe "#generate_secret_code" do
    it "returns a string of length 4" do
      code = @maker.generate_secret_code
      expect(code.length).to eq(4)
    end

    it "returns only characters from R, G, Y, B" do
      code = @maker.generate_secret_code
      expect(code).to match(/\A[RGYB]{4}\z/)
    end

    it "can contain duplicates" do
      codes = Array.new(100) { @maker.generate_secret_code }
      has_duplicate = codes.any? { |code| code.chars.uniq.length < 4 }
      expect(has_duplicate).to be true
    end
  end

  describe "#compare_guess_to_secret_code" do
    it "returns 1 exact, 3 color for secret RGYB and guess RBGY" do
      @maker.secret_code = "RGYB"
      result = @maker.compare_guess_to_secret_code("RBGY")
      expect(result).to eq({ exact_matches: 1, color_only_matches: 3 })
    end

    it "returns 2 exact, 2 color for secret RGYB and guess RGBY" do
      @maker.secret_code = "RGYB"
      result = @maker.compare_guess_to_secret_code("RGBY")
      expect(result).to eq({ exact_matches: 2, color_only_matches: 2 })
    end

    it "returns 1 exact, 0 color for secret RGYB and guess BBBB" do
      @maker.secret_code = "RGYB"
      result = @maker.compare_guess_to_secret_code("BBBB")
      expect(result).to eq({ exact_matches: 1, color_only_matches: 0 })
    end

    it "returns 1 exact, 0 color for secret RGYB and guess RRRR" do
      @maker.secret_code = "RGYB"
      result = @maker.compare_guess_to_secret_code("RRRR")
      expect(result).to eq({ exact_matches: 1, color_only_matches: 0 })
    end

    it "returns 0 exact, 4 color for secret RGYB and guess GRBY" do
      @maker.secret_code = "RGYB"
      result = @maker.compare_guess_to_secret_code("GRBY")
      expect(result).to eq({ exact_matches: 0, color_only_matches: 4 })
    end

    it "returns 4 exact, 0 color for a perfect match" do
      @maker.secret_code = "RGYB"
      result = @maker.compare_guess_to_secret_code("RGYB")
      expect(result).to eq({ exact_matches: 4, color_only_matches: 0 })
    end

    it "returns 0 exact, 0 color when no matches at all" do
      @maker.secret_code = "RGYB"
      result = @maker.compare_guess_to_secret_code("CCCC")
      expect(result).to eq({ exact_matches: 0, color_only_matches: 0 })
    end

    it "correctly handles duplicates in secret" do
      @maker.secret_code = "RRGB"
      result = @maker.compare_guess_to_secret_code("RRRR")
      expect(result).to eq({ exact_matches: 2, color_only_matches: 0 })
    end

    it "correctly handles duplicates in guess" do
      @maker.secret_code = "RRGB"
      result = @maker.compare_guess_to_secret_code("BBRR")
      expect(result).to eq({ exact_matches: 0, color_only_matches: 3 })
    end
  end

  describe "#valid_user_guess?" do
    # ✅ Positive cases
    it "returns true when guess contains only R, G, Y, B" do
      expect(@maker.valid_user_guess?("RGYB")).to be true
    end

    it "returns true when guess uses lowercase letters" do
      expect(@maker.valid_user_guess?("rgyb")).to be true
    end

    it "returns true when guess mixes case" do
      expect(@maker.valid_user_guess?("RgYb")).to be true
    end

    # ❌ Negative cases
    it "returns false when guess is too short" do
      expect(@maker.valid_user_guess?("RGY")).to be false
    end

    it "returns false when guess is too long" do
      expect(@maker.valid_user_guess?("RGYBB")).to be false
    end

    it "returns false when guess has only invalid characters" do
      expect(@maker.valid_user_guess?("ZZZZ")).to be false
    end

    it "returns false when guess has a mix of valid and invalid characters" do
      expect(@maker.valid_user_guess?("RGZX")).to be false
    end
  end
end
