class Api::V1::SlackController < ApplicationController

 skip_before_action :verify_authenticity_token
 before_action :verify_slack_token

def create
 render nothing: true, status: :ok and return unless responder.respond?

 if params[:command].present?
   render json: {
     "attachments": [
         {
             "fallback": responder.response.to_s,
             "color": "#ffb300",
             "title": "As #{responder.get_name} would say...",
             "title_link": "https://impithy.herokuapp.com" + responder.get_link.to_s,
             "fields": [
                 {
                     "title": responder.response.to_s,
                     "short": false
                 }
             ],
             "footer": "posted by #{params[:user_name]}"
         }
       ]
     }
     responder.response.to_s
 else
   render json: { text: "Oops, I didn't understand that. Try '/pithy help' for tips." }
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
