class Slack::Responder

 def initialize(message)
   @message = message
 end

 def respond?
   response.present?
 end

 def response
   if @message.empty?
     "Hello this is Pithy! Please tell me which esteemed leader you are looking for (e.g. '/pithy trump')"
   else
     person = Person.friendly.find(@message)
     @response ||= person.quotes.select(:id, :text).sample['text']
   end
 end

 private

 attr_reader :message

end
