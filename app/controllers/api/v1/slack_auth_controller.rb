require 'net/http'
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
    create_team if params[:state] = @state.state
    if @team.save
      puts Team.last.inspect
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
    url = URI.parse("https://slack.com/api/oauth.access?client_id=" + client_id + "&client_secret=" + client_secret + "&code=" + code)
    res = HTTParty.get(url.to_s)
    puts url
    puts res
    @team = Team.new(  team_id: res['team_id'],
                          scope: res['scope'],
                          team_name: res['team_name'],
                          channel_name: res['incoming_webhook']['channel'],
                          channel_id: res['incoming_webhook']['channel_id'],
                          url: res['incoming_webhook']['url'],
                          configuration_url: res['incoming_webhook']['channel_id'],
                          token: res['access_token'],
                          scope: res['scope']
                        )
  end

end
