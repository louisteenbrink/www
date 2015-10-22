require "rails_helper"

RSpec.describe "Home", type: :feature do
  it "works in French" do
    visit '/'
    print page.html  # DEBUG, will be removed
    expect(page).to have_selector("h1", text: "apprenez à coder")
  end

  it "works in English" do
    visit '/en'
    expect(page).to have_selector("h1", text: "learn to code")
  end
end
