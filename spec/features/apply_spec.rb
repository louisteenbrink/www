require "rails_helper"

RSpec.describe "Apply process", type: :feature do
  it "fails if motivation is too short (in English)" do
    visit '/apply/paris'

    default_identity
    fill_in "source", with: "Google"
    fill_in 'motivation', with: 'Not motiviated enough...'
    click_button 'apply_btn'

    expect(page.current_path).to eq "/apply/paris"
    expect(page).to have_selector(".error", text: "is too short")
  end

  it "fails if motivation is too short (in French)" do
    visit '/postuler/paris'

    default_identity
    fill_in "source", with: "Google"
    fill_in 'motivation', with: 'Pas assez motivé...'
    click_button 'apply_btn'

    expect(page.current_path).to eq "/apply/paris"
    expect(page).to have_selector(".error", text: "est trop court")
  end

  it "works if motivation is > 140 characters (in French)" do
    visit '/postuler/paris'

    default_identity
    fill_in "source", with: "Google"
    fill_in 'motivation', with: "a" * 140

    expect {
      click_button 'apply_btn'
    }.to change { Apply.count }.by(1)

    expect(page.current_path).to eq "/merci"
  end

  it "works if motivation is > 140 characters (in English)" do
    visit '/apply/paris'

    default_identity
    fill_in "source", with: "Google"
    fill_in 'motivation', with: "a" * 140

    expect {
      click_button 'apply_btn'
    }.to change { Apply.count }.by(1)

    expect(page.current_path).to eq "/thanks"
  end

  def default_identity
    within("#apply") do
      fill_in 'first_name', with: 'George'
      fill_in 'last_name', with: 'Abitbol'
      fill_in 'age', with: 42
      fill_in 'email', with: 'george@abitbol.com'
      fill_in 'phone', with: '+3312345678'
      fill_in 'codecademy_username', with: 'sbfrr' # Seb Ferré did 100% :)
    end
  end
end
