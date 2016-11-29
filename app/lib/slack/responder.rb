class Slack::Responder

  def initialize(nickname)
    @nickname = nickname
  end

  def respond?
    response.present?
  end

  def response
    if @nickname == "help"
      help_text
    elsif @nickname == nil || @nickname.empty?
      empty_request
    else
      get_person
      get_quote
    end
  end

  def get_name
    name
  end

  def get_link
    link
  end

  private

  attr_reader :message, :name, :link

  def get_person
    @person = Person.friendly.find(@nickname)
    @name = @person.first_name + " " + @person.last_name
    @link = "/people/#{@nickname}"
    rescue ActiveRecord::RecordNotFound
  end

  def get_quote
    if @person != nil
      @response ||= @person.quotes.select(:id, :text).sample['text']
    else
      "Oops. Sorry, I couldn't find that person. Try again! (e.g. '/pithy trump')"
    end
  end

  def help_text
    "To use Pithy, type `/pithy` plus the name of the esteemed leader you want a quote from.\n For example, `/pithy trump` will return a wonderful quote from Donald Trump, such as 'Unbelievable. Unbelievable.'\n Isn't that unbelievable?!"
  end

  def empty_request
    "Hello this is Pithy! Please tell me which esteemed leader you are looking for (e.g. '/pithy trump')"
  end

end
