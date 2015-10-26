require "rails_helper"

RSpec.describe "Program", type: :feature do
  it "works in French" do
    visit '/programme'
    expect(page).to have_selector("h1", text: "Programme FullStack")
  end

  it "works in English" do
    visit '/program'
    expect(page).to have_selector("h1", text: "FullStack program")
  end
end
