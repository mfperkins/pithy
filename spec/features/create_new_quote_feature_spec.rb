require 'rails_helper'

feature 'Create a new quote for a person' do

  before(:each) do
    Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
  end

  context 'User logged in' do

    scenario 'User can fill in a form and save a quote' do
      visit '/'
      click_on("Donald Trump")
      click_on("Add quote")
      fill_in 'quote[text]', with: "It's just great. Great."
      click_on("save quote")
      expect(page).to have_content("It's just great. Great.")
    end

  end

end
