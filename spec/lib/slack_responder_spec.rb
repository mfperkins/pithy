require 'rails_helper'

describe Slack::Responder do

  message = "trump"
  message_2 = "example"
  message_3 = nil
  message_4 = "help"
  let(:responder) {described_class.new(message)}
  let(:responder_2) {described_class.new(message_2)}
  let(:responder_3) {described_class.new(message_3)}
  let(:responder_4) {described_class.new(message_4)}

  before(:each) do
    Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
    Quote.create(text: "Unbelievable. Unbelievable.", person_id: Person.last.id)
  end

  context 'When using a valid nickname, it' do

    it '#response should give you a quote' do
      expect(responder.response).to eq("Unbelievable. Unbelievable.")
    end

    it '#get_name should give you the first and last name of the person' do
      responder.response
      expect(responder.get_name).to eq("Donald Trump")
    end

    it '#get_link should return the URL of the person' do
      responder.response
      expect(responder.get_link).to eq("/people/trump")
    end

  end

  context 'When called with an invalid nickname, it' do

    it 'should ask you who you wanted a quote from' do
      expect(responder_2.response).to eq("Oops. Sorry, I couldn't find that person. Try again! (e.g. '/pithy trump')")
    end

  end

  context 'When called without a nickname, it' do

    it 'should ask you who you wanted a quote from' do
      expect(responder_3.response).to eq("Hello this is Pithy! Please tell me which esteemed leader you are looking for (e.g. '/pithy trump')")
    end

  end

  context 'When called with "/help", it' do

    it 'should give you some tips' do
      expect(responder_4.response).to eq("To use Pithy, type `/pithy` plus the name of the esteemed leader you want a quote from.\n For example, `/pithy trump` will return a wonderful quote from Donald Trump, such as 'Unbelievable. Unbelievable.'\n Isn't that unbelievable?!")
    end

  end

end
