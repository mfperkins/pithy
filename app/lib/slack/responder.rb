class Slack::Responder

 def initialize(message)
   @message = message
 end

 def respond?
   response.present?
 end

 def response
   person = Person.friendly.find(params[:text])
   @response ||= person.quotes.select(:id, :text).sample
 end

 private

 attr_reader :message

end
