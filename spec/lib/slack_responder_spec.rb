require 'rails_helper'

describe Slack::Responder do

  user_name = "someone"
  nickname = "trump"
  nickname_2 = "example"
  nickname_3 = nil
  nickname_4 = "help"
  nickname_5 = "people"
  let(:responder) {described_class.new(nickname, user_name)}
  let(:responder_2) {described_class.new(nickname_2, user_name)}
  let(:responder_3) {described_class.new(nickname_3, user_name)}
  let(:responder_4) {described_class.new(nickname_4, user_name)}
  let(:responder_5) {described_class.new(nickname_5, user_name)}

  before(:each) do
    Person.create(first_name: "Barack", last_name: "Obama", nickname: "obama")
    Person.create(first_name: "Winson", last_name: "Churchill", nickname: "churchill")
    Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
    Quote.create(text: "Unbelievable. Unbelievable.", person_id: Person.last.id, display_count: 10)
  end

  context 'When using a valid nickname, it' do

    it '#response should give you a quote' do
      expect(responder.response[:attachments][0][:fields][0]["value"]).to eq("Unbelievable. Unbelievable.")
    end

    it '#response should increase the display_count by 1' do
      responder.response
      expect{responder.response}.to change{Quote.last.display_count}.by 1
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
      expect(responder_2.response[:text]).to eq("Oops. Sorry @someone, I couldn't find that person. Try again! (e.g. `/pithy trump`)")
    end

  end

  context 'When called without a nickname, it' do

    it 'should ask you who you wanted a quote from' do
      expect(responder_3.response[:text]).to eq("Hello @someone, this is Pithy! Please tell me which esteemed leader you are looking for (e.g. `/pithy trump`)")
    end

  end

  context "When called with '/help', it" do

    it 'should give you some tips' do
      expect(responder_4.response[:attachments][0]["text"] ).to eq("Hi @someone! To get started, just type `/pithy` plus the name of an esteemed leader.\n\n For example, `/pithy trump` will return a wonderful quote from Donald Trump, such as 'Unbelievable. Unbelievable.'\n\n Isn't that unbelievable?!")
    end

  end

  context "When called with '/people', it" do

    it 'should give you some tips' do
      expect(responder_5.response[:attachments][0]["text"] ).to eq("Hi @someone! Here is a list of all the people you can get quotes from:\n\nWinson Churchill `/pithy churchill`\nBarack Obama `/pithy obama`\nDonald Trump `/pithy trump`\n")
    end

  end

end
