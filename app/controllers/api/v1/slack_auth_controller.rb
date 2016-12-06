require 'net/http'
require 'securerandom'
require 'json'

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
      welcome_message
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
    @team = Team.new( team_id: res['team_id'],
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

  def welcome_message
    url = @team.url
    welcome = HTTParty.post(url.to_str,
      :body => { :attachments => [ {
                    :fallback => "Welcome to Pithy. Type `/pithy help` for more info.",
                    :color => "#36a64f",
                    :title => "Welcome to Pithy",
                    :title_link => "https://www.itspithy.com/",
                    :text => "Thanks for installing Pithy. Together we're going to make your Slack conversations way more exciting. Here are some tips to get you started.",
                    :fields => [
                      {
                        :value => "*Send a quote* \n To send a quote simply type `/pithy` plus the person you want a quote from. For example, `/pithy churchill` will send you a pithy quote from Winston Churchill. \n\n *Get a list of people* \n To get a list of all the people you can get quotes from simply call `/pithy people`.\n\n *Help!* \n Ask Pithy for help with `/pithy help`.\n\n *Send feedback* \n We\'d love to know what you think, so drop us a line: hello@itspithy.com."
                      }
                    ],
                    :mrkdwn_in => ["fields"]
               } ] }.to_json,
      :headers => { 'Content-Type' => 'application/json' } )
  end

end
