require 'rails_helper'

feature 'Create, edit, delete quotes for a person' do

  before(:each) do
    Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
  end

  context 'User logged in' do

    before(:each) do
      user_sign_up
    end

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

  context 'User not logged in' do

    scenario 'User tries to add a quote' do
      visit '/'
      click_on("Donald Trump")
      click_on("Add quote")
      expect(page).to have_current_path("/users/sign_in")
    end

    scenario "User cannot edit someone else's quote" do
      user_sign_up
      create_quote
      user_sign_out
      user_sign_up(email = "test2@email.com", password = "hello", password_confirmation = "hello")
      visit '/'
      click_on("Donald Trump")
      expect(page).to_not have_content("Edit")
    end

  end

end
