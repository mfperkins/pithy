require 'rails_helper'

describe Slack::Responder do

  message = "trump"
  message_2 = ""
  subject (:responder) {described_class.new(message)}
  let(:responder_2) {described_class.new(message_2)}

  before(:each) do
    Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
    Quote.create(text: "Unbelievable. Unbelievable.", person_id: Person.last.id)
  end

  context 'When called with a valid message, it' do

    it 'should give you a quote' do
      expect(subject.response).to eq("Unbelievable. Unbelievable.")
    end

  end

  context 'When called without a message, it' do

    it 'should ask you who you wanted a quote from' do
      expect(responder_2.response).to eq("Hello this is Pithy! Please tell me which esteemed leader you are looking for (e.g. '/pithy trump')")
    end

  end

end
