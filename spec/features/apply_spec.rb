require "rails_helper"

RSpec.describe "Apply process", type: :feature do
  it "fails if motivation is too short" do
    visit '/postuler'

    default_identity
    fill_in 'motivation', with: 'Not motiviated enough...'
    click_button 'apply_btn'

    expect(page.current_path).to eq "/apply"
    expect(page).to have_selector(".text-area-has-error", text: "est trop court")
  end

  it "works if motivation is > 140 characters" do
    visit '/postuler'

    default_identity
    fill_in 'motivation', with: "a" * 140

    expect {
      click_button 'apply_btn'
    }.to change { Apply.count }.by(1)

    expect(page.current_path).to eq "/merci"
  end

  def default_identity
    within("#apply") do
      fill_in 'first_name', with: 'George'
      fill_in 'last_name', with: 'Abitbol'
      fill_in 'age', with: 42
      fill_in 'email', with: 'george@abitbol.com'
      fill_in 'phone', with: '+3312345678'
    end
  end
end
