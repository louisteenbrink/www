require 'rails_helper'

RSpec.describe 'Free Track Page', type: :feature, js: true do
  it 'fails if bad email' do
    visit '/learn-to-code'

    fill_in 'prospect_email', with: 'not a valid email'
    select 'London', from: 'prospect_city'

    click_button 'prospect_submit'

    expect(page).to have_css('#prospect_email.error')
  end

  it 'prefills the city if specified in params' do
    true
  end
end
