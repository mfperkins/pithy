require 'rails_helper'

feature 'Create, edit, delete quotes for a person' do

  before(:each) do
    Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
  end

  context 'User logged in' do

    scenario 'User can fill in a form and save a quote' do
      create_quote
      expect(page).to have_content("It's just great. Great.")
    end

    scenario 'User can edit a quote' do
      create_quote
      click_on("Edit")
      fill_in 'quote[text]', with: "What a wonderful election. Wonderful."
      click_on("save quote")
      expect(page).to have_content("What a wonderful election. Wonderful.")
    end

    scenario 'User can delete a quote' do
      create_quote
      click_on("Delete")
      expect(page).not_to have_content("It's just great. Great.")
    end


  end

end
