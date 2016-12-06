require 'rails_helper'

describe "API::V1::SlackAuthController" do

  context 'Team is able sign up for Pithy' do

    xit 'will create a new Team for you' do

      Slack_State.create(state: 123456789)

      get '/api/v1/slack_auth', params: { state: 123456789, code: "abc" }

      expect(response).to be_success
      expect(response).to receive(:params).with()
      expect(Team.count).to change_by 1
    end

  end

end
