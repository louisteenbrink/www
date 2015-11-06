require "rails_helper"

RSpec.describe "Alumni", type: :feature do
  it "works in French" do
    visit '/fr/alumni'
    expect(page).to have_selector("h1", text: "Les Alumni du Wagon")
  end

  it "works in English" do
    visit '/alumni'
    expect(page).to have_selector("h1", text: "Le Wagon's Alumni")
  end
end
