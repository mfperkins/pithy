require 'json'

class Slack::Responder

  def initialize(nickname, user_name)
    @the_response = {}
    @nickname = nickname
    @user_name = user_name
  end

  def respond?
    response.present?
  end

  def response
    if @nickname == "help"
      build_help_response
    elsif @nickname == "people"
      build_list_of_people_response
    elsif @nickname == nil || @nickname.empty?
      build_no_nickname_response
    else
      get_person
      @person == nil ? build_no_person_response : build_person_response
    end
    the_response
  end

  def get_name
    name
  end

  def get_link
    link
  end

  def get_list_of_people
    people.join("")
  end

  def get_quote_text
    quote_text
  end

  private

  attr_reader :message, :name, :link, :the_response, :people, :quote_text

  def get_person
    @person = Person.friendly.find(@nickname.downcase)
    @name = @person.first_name + " " + @person.last_name
    @link = "/people/#{@nickname}"
    generate_quote
    rescue ActiveRecord::RecordNotFound
  end

  def generate_quote
    @quote ||= @person.quotes.sample
    @quote_text = @quote.text
    Quote.increment_counter(:display_count, @quote.id)
    @quote.save
  end

  def generate_list_of_people
    @people = []
    all_people = Person.order(:last_name)
    all_people.each do |someone|
      @people << "#{someone.first_name} #{someone.last_name} `/pithy #{someone.nickname}`\n"
    end
  end

  def build_help_response
    @the_response[:response_type] = "ephemeral"
    @the_response[:text] = "*How to use /pithy*"
    @the_response[:attachments] = [{}]
    @the_response[:attachments][0]["color"] = "#36a64f"
    @the_response[:attachments][0]["text"] = "Hi @#{@user_name}! To get started, just type `/pithy` plus the name of an esteemed leader.\n\n For example, `/pithy trump` will return a wonderful quote from Donald Trump, such as 'Unbelievable. Unbelievable.'\n\n Isn't that unbelievable?!"
    @the_response[:attachments][0]["mrkdwn_in"] = ["text"]
  end

  def build_person_response
    @the_response[:response_type] = "in_channel"
    @the_response[:attachments] = [{}]
    @the_response[:attachments][0] = {fields: [{}]}
    @the_response[:attachments][0]["fallback"] = get_quote_text.to_s
    @the_response[:attachments][0]["color"] = "#ffb300"
    @the_response[:attachments][0]["title"] = "As #{get_name} would say..."
    @the_response[:attachments][0]["title_link"] = "https://impithy.herokuapp.com" + get_link.to_s
    @the_response[:attachments][0][:fields][0]["value"] = get_quote_text.to_s
    @the_response[:attachments][0][:fields][0]["short"] = false
    @the_response[:attachments][0][:footer] = "posted by @#{@user_name}"
  end

  def build_no_person_response
    @the_response[:response_type] = "ephemeral"
    @the_response[:text] = "Oops. Sorry @#{@user_name}, I couldn't find that person. Try again! (e.g. `/pithy trump`)"
  end

  def build_no_nickname_response
    @the_response[:response_type] = "ephemeral"
    @the_response[:text] = "Hello @#{@user_name}, this is Pithy! Please tell me which esteemed leader you are looking for (e.g. `/pithy trump`)"
  end

  def build_list_of_people_response
    generate_list_of_people
    @the_response[:response_type] = "ephemeral"
    @the_response[:text] = "*People on Pithy*"
    @the_response[:attachments] = [{}]
    @the_response[:attachments][0]["color"] = "#36a64f"
    @the_response[:attachments][0]["text"] = "Hi @#{@user_name}! Here is a list of all the people you can get quotes from:\n\n" + get_list_of_people.to_s
    @the_response[:attachments][0]["mrkdwn_in"] = ["text"]

  end

end
