require 'rails_helper'

RSpec.describe 'Home', type: :system do
  it 'shows greeting' do
    visit root_path
    expect(page).to have_content 'Hello World!'
  end
end
