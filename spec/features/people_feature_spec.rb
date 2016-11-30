require 'rails_helper'

feature 'List of all people' do

  before(:each) do
    Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
    Person.create(first_name: "Barack", last_name: "Obama", nickname: "obama")
  end

  context 'User not logged in' do

    require 'rails_helper'

    feature 'Homepage' do

      context 'User sees Slack Install button & welcome message' do

        scenario 'user not logged in' do
          visit '/'
          expect(page).to have_selector(:link_or_button, 'Add to Slack')
          within '#welcome-quote' do
            expect(page).to have_content "Too much agreement kills a chat - Eldridge Cleaver"
          end
        end

      end

    end


    scenario 'User sees a list of all people' do
      visit '/'
      expect(page).to have_content "Donald Trump"
      expect(page).to have_content "Barack Obama"
    end

  end

  context 'User logged in' do

    before(:each) do
      user_sign_up
      add_person
    end

    scenario 'User can create a new person' do
      visit '/'
      expect(page).to have_content "Winston Churchill"
    end

    scenario 'User can edit a person they created' do
      visit '/'
      click_on 'Edit'
      fill_in 'person[first_name]', with: "Mr"
      click_on 'save person'
      expect(page).to have_content "Mr Churchill"
    end

    scenario 'User can edit a person they created' do
      visit '/'
      click_on 'Delete'
      expect(page).to_not have_content "Winston Churchill"
    end

  end

end
