require 'json'

class Api::V1::SlackController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :verify_slack_token

  def create
    render nothing: true, status: :ok and return unless responder.respond?
    if params[:command].present?
      render json: responder.response.to_json
    else
      render json: {
        "response_type": "ephemeral",
	       "text": "Sorry @#{params[:user_name]}, I didn't understand that. Try `/pithy help` for tips."
       }
    end

  end

  private

  def responder
    @responder ||= Slack::Responder.new(params[:text], params[:user_name])
  end

  def verify_slack_token
    render nothing: true, status: :forbidden and return unless Slack::TOKENS.include?(params[:token])
  end

end
