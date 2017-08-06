require 'rails_helper'

RSpec.describe 'Free Track Page', type: :feature do
  it 'fails if bad email', js: true do
    visit '/learn-to-code'

    fill_in 'prospect_email', with: 'not a valid email'
    select 'London', from: 'prospect_city'

    expect { click_button 'prospect_submit' }.to_not(change { Prospect.count })
    expect(page.current_path).to eq '/learn-to-code'
    expect(page).to have_css('input#prospect_email.error')
    expect(page).to have_selector('.email-error', visible: true)
  end

  it 'prefills the city if specified in params' do
    visit '/learn-to-code/london'

    expect(page).to have_select('prospect_city', selected: 'London')
  end

  it 'works if good email', js: true do
    visit '/learn-to-code'

    fill_in 'prospect_email', with: 'valid_email@gmail.com'
    select 'Berlin', from: 'prospect_city'

    expect do
      click_button 'prospect_submit'
      sleep(3)
    end.to change { Prospect.count }.by(1)
    expect(page.current_path).to eq '/learn-to-code'
    expect(page).to have_selector('.email-error', visible: false)
  end
end
