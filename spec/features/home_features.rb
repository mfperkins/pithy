require 'rails_helper'

feature 'Static pages' do

  context 'User not logged in' do

    scenario 'User sees privacy policy' do
      visit '/static/privacy-policy'
      expect(page).to have_content("Pithy Privacy Policy")
    end

    scenario 'User sees support page' do
      visit '/static/help'
      expect(page).to have_content("Pithy Help Center")
    end

  end

end
