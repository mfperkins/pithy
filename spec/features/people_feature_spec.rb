require 'rails_helper'

feature 'List of all people' do

  context 'User not logged in' do

    before(:each) do
      Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
      Person.create(first_name: "Barack", last_name: "Obama", nickname: "obama")
    end

    scenario 'User sees slack button & welcome message' do
      visit '/'
      expect(page).to have_selector(:link_or_button, 'Add to Slack')
      within '#welcome-quote' do
        expect(page).to have_content "Too much agreement kills a chat - Eldridge Cleaver"
      end
    end

    scenario 'User cards of all people' do
      visit '/'
      expect(page).to have_content "Donald Trump"
      expect(page).to have_content "Barack Obama"
    end

  end

  context 'User logged in' do

    before(:each) do
      user_sign_up
      add_person(first_name = "Bob", last_name = "Marley", nickname = "bob")
    end

    scenario 'User can create a new person' do
      visit '/'
      expect(page).to have_content "Bob Marley"
      expect(page.find('.card-image')['src']).to have_content("")
    end

    scenario 'User can edit a person they created' do
      visit '/'
      click_on 'Edit'
      fill_in 'person[first_name]', with: "Mr"
      click_on 'save person'
      expect(page).to have_content "Mr Marley"
    end

    scenario 'User can edit a person they created' do
      visit '/'
      click_on 'Delete'
      expect(page).to_not have_content "Bob Marley"
    end

  end

  context 'User logged in' do

    before(:each) do
      user_sign_up
    end

    scenario 'User cannot create a person with nickname "help"' do
      visit '/'
      click_on 'perm_identity'
      fill_in 'person[first_name]', with: "I"
      fill_in 'person[last_name]', with: "need"
      fill_in 'person[nickname]', with: "help"
      click_on "save"
      expect(page.body).to have_content ("Nickname already taken. Choose another one!")
    end

    scenario 'User cannot create a person with nickname "people"' do
      visit '/'
      click_on 'perm_identity'
      fill_in 'person[first_name]', with: "I"
      fill_in 'person[last_name]', with: "want"
      fill_in 'person[nickname]', with: "people"
      click_on "save"
      expect(page.body).to have_content ("Nickname already taken. Choose another one!")
    end

  end

end
