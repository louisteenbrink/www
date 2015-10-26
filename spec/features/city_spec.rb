require "rails_helper"

RSpec.describe "City page", type: :feature do
  context "for Paris" do
    it "works in French" do
      visit '/fr/paris'
      expect(page).to have_selector("h1", text: "apprenez à coder")
      expect(page).to have_selector("strong", text: "Paris")
    end

    it "works in English" do
      visit '/en/paris'
      expect(page).to have_selector("h1", text: "learn to code")
      expect(page).to have_selector("strong", text: "Paris")
    end
  end
end
