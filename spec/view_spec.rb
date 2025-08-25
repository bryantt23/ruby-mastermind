require "view"

RSpec.describe View do
  describe "#show_welcome" do
    it "returns the welcome message" do
      view = View.new
      expect(view.show_welcome).to eq("Welcome to Code Breaker!")
    end
  end
end
