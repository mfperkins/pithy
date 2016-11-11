require 'rails_helper'

feature 'List of all people' do

  before(:each) do
    user_sign_up
    Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
    Person.create(first_name: "Barack", last_name: "Obama", nickname: "obama")
  end

  context 'User logged in' do

    before(:each) do

    end

    scenario 'User logs in and sees a list of all people' do
      visit '/'
      expect(page).to have_content "Trump"
      expect(page).to have_content "Obama"
    end

  end

end
