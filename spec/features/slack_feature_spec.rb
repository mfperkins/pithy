require 'rails_helper'

describe "Slack Authentication" do

  context 'Successful authentication' do

    it 'Store a random state on button-click' do

      visit '/'
      click_on 'Add to Slack'
      expect(Team.last(:scope)).to_not be nil

    end

  end

end
