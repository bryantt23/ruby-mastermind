# spec/view_spec.rb
require "view"

RSpec.describe View do
  before do
    @view = View.new
  end

  describe "#show_welcome" do
    it "returns the welcome message" do
      expect(@view.show_welcome).to eq("Welcome to Code Breaker!")
    end
  end

  describe "#show_remaining_chances" do
    it "returns message with remaining chances" do
      expect(@view.show_remaining_chances(12)).to eq("You have 12 chances left...")
    end
  end

  describe "#show_guess_result" do
    it "returns formatted result message" do
      feedback = { exact_matches: 2, color_only_matches: 1 }
      expect(@view.show_guess_result(feedback)).to eq("You have 2 exact match(es), 1 color match(es)")
    end
  end

  describe "#show_win_loss" do
    it "returns victory message when passed :win" do
      expect(@view.show_win_loss(:win)).to eq("You are a Master Code Breaker!")
    end

    it "returns loss message when passed :loss" do
      expect(@view.show_win_loss(:loss)).to eq("You are broken by the code :(")
    end
  end

  describe "#show_actual_code" do
    it "returns message revealing the actual code" do
      expect(@view.show_actual_code("RGYB")).to eq("The code was RGYB")
    end
  end
end
