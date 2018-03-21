require "rails_helper"

RSpec.describe "Download Syllabus", type: :feature do
  it "displays the download button" do
    visit '/program'
    expect(page).to have_link("Download Syllabus")
  end

  it 'displays a modal with a form', js: true do
    visit '/program'
    click_on "Download Syllabus"
    within('#download-syllabus-modal') do
      expect(page).to have_content('Get our full syllabus')
    end
  end
  context "form inputs are valid" do
    it 'creates a prospect when form is submitted', js: true do
      name = 'John Smith'
      email = 'johnsmith@smith.com'
      city = 'Melbourne'
      visit '/program'
      click_on "Download Syllabus"
      within('#download-syllabus-modal') do
        fill_in 'Name', with: name
        fill_in 'Email', with: email
        select city, from: 'City'
        click_on "Receive our syllabus by email"
      end
      expect(page).to have_text "All good! Please check your inbox."
      prospect = Prospect.last
      expect(prospect.name).to eq name
      expect(prospect.email).to eq email
      expect(prospect.city).to eq city.downcase
      expect(prospect.origin).to eq 'syllabus'
    end
  end
  context "form inputs are invalid" do
    it 're-render the form with error messages', js: true do
      name = 'John Smith'
      city = 'Melbourne'
      visit '/program'
      click_on "Download Syllabus"
      within('#download-syllabus-modal') do
        fill_in 'Name', with: name
        select city, from: 'City'
        click_on "Receive our syllabus by email"
      end
      expect(page).to have_text "can't be blank"
    end
  end
end
