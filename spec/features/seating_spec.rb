require 'rails_helper'

describe "User submit inputs", type: :feature do
  it 'at homepage' do
    visit airplane_seating_path

    fill_in 'Column/Rows:', with: '[[3,2], [4,3], [2,3], [3,4]]'
    fill_in 'Number of passengers:', with: '30'

    click_button 'Submit'

    expect(page).to have_content('airplane seats generated')
  end
end
