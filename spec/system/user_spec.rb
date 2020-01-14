require 'rails_helper'

RSpec.feature 'Home', type: :system do
  scenario 'shows greeting' do
    visit root_path
    expect(page).to have_content 'Hello World!'
  end
end
