require "rails_helper"

RSpec.describe "Home", type: :feature do
  it "works in French" do
    visit '/fr'
    expect(page).to have_selector("h2", text: "apprenez à coder")
  end

  it "works in English" do
    visit '/'
    expect(page).to have_selector("h2", text: "learn to code")
  end
end
