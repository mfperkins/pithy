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
    url = URI.parse("https://slack.com/api/oauth.access?client_id=" + client_id + "&client_secret=" + client_secret + "&code=" + code)
    res = HTTParty.get(url.to_s)
    puts url
    puts res
    # req = Net::HTTP::Get.new(url.to_s)
    # res = Net::HTTP.start(url.host, url.port) {|http|
    #   http.request(req)
    # }
    # puts res.body

    {"ok"=>true, "access_token"=>"xoxp-99706781393-101093522870-111575416004-bb07ac689e829cebc31e9e566b040d33", "scope"=>"identify,commands,incoming-webhook", "user_id"=>"U2Z2RFCRL", "team_name"=>"silence", "team_id"=>"T2XLSNZBK", "incoming_webhook"=>{"channel"=>"#general", "channel_id"=>"C2XLSPMHP", "configuration_url"=>"https://silense.slack.com/services/B39H7R0H3", "url"=>"https://hooks.slack.com/services/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"}}

  end

end
