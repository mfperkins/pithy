class Slack::Responder

 def initialize(message)
   @message = message
 end

 def respond?
   response.present?
 end

 def response
   person = Person.friendly.find(@message)
   @response ||= person.quotes.select(:id, :text).sample['text']
 end

 private

 attr_reader :message

end
