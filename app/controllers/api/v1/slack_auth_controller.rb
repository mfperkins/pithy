require 'json'
require 'securerandom'

class Api::V1::SlackAuthController < ApplicationController

  def new
    @state = Slack_State.new
    new_state = generate_state
    @state.update(state: new_state)
    redirect_to "https://slack.com/oauth/authorize?scope=incoming-webhook,commands&state=" + new_state + "&client_id=110955535366.110968354023"
  end

  def index
    @state = Slack_State.find_by(state: params[:state])
    if params[:state] = @state.state
      create_team
      redirect_to root_path
      flash[:notice] = "Success! You added Pithy to your Slack Team"
    else
      redirect_to root_path
      flash[:error] = "Ooops, something went wrong. Please try again."
    end
  end

  private

  def generate_state
    SecureRandom.uuid
  end

  def create_team
    code = params[:code]
    client_id = ENV.fetch('SLACK_CLIENT_ID')
    client_secret = ENV.fetch('SLACK_CLIENT_SECRET')
    slack_response = HTTParty.get("https://slack.com/api/oauth.access&client_id=" + client_id + "&client_secret=" + client_secret + "&code=" + code)
    puts slack_response
  end

end
