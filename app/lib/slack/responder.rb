class Slack::Responder

  def initialize(nickname)
    @nickname = nickname
  end

  def respond?
    response.present?
  end

  def response
    if @nickname == nil || @nickname.empty?
      "Hello this is Pithy! Please tell me which esteemed leader you are looking for (e.g. '/pithy trump')"
    else
      get_person
      if @person != nil
        @response ||= @person.quotes.select(:id, :text).sample['text']
      else
        "Oops. Sorry, I couldn't find that person. Try again! (e.g. '/pithy trump')"
      end
    end
  end

  def get_name
    name
  end

  def get_link
    link
  end


  private

  def get_person
    @person = Person.friendly.find(@nickname)
    @name = @person.first_name + " " + @person.last_name
    @link = "/people/#{@nickname}"
    rescue ActiveRecord::RecordNotFound
  end

  attr_reader :message, :name, :link

end
