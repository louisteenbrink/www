require "rails_helper"

RSpec.describe "Alumni", type: :feature do
  it "works in French" do
    visit '/fr/alumni'
    expect(page).to have_selector(:css, "body.students-index")
  end

  it "works in English" do
    visit '/alumni'
    expect(page).to have_selector(:css, "body.students-index")
  end
end
