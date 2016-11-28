class Api::V1::SlackController < ApplicationController

 skip_before_action :verify_authenticity_token
 before_action :verify_slack_token

def create
 render nothing: true, status: :ok and return unless responder.respond?

 if params[:command].present?
   render plain: responder.response.to_s
 else
   render json: { text: responder.response.to_s }
 end

end

 private

 def responder
   @responder ||= Slack::Responder.new(params[:text])
 end

 def verify_slack_token
   render nothing: true, status: :forbidden and return unless Slack::TOKENS.include?(params[:token])
 end

end
