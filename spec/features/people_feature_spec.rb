require 'rails_helper'

feature 'List of all people' do

  before(:each) do
    Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
    Person.create(first_name: "Barack", last_name: "Obama", nickname: "obama")
  end

  context 'User not logged in' do

    scenario 'User logs in and sees a list of all people' do
      visit '/'
      expect(page).to have_content "Donald Trump"
      expect(page).to have_content "Barack Obama"
    end

  end

  context 'User logged in' do

    before(:each) do
      user_sign_up
    end

    scenario 'User can create a new person' do
      add_person
      expect(page).to have_content "Winston Churchill"
    end

  end

end
