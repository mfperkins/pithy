require 'rails_helper'

describe "Slack API" do

  context 'For a complete request' do

    it 'will give you a correct quote for a person (e.g. "/pithy trump")' do

      Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
      Quote.create(text: "Unbelievable. Unbelievable.", person_id: Person.last.id)

      post '/api/v1/slack', params: {
        token: ENV.fetch('SLACK_TOKENS'),
        "user_name"=>"someone",
        "command"=>"/pithy",
        "text"=>"trump"
      }
      expect(response).to be_success
      expect(response.body).to eq('{"response_type":"in_channel","attachments":[{"fields":[{"value":"Unbelievable. Unbelievable.","short":false}],"fallback":"Unbelievable. Unbelievable.","color":"#ffb300","title":"As Donald Trump would say...","title_link":"https://impithy.herokuapp.com/people/trump","footer":"posted by @someone"}]}')
    end

    it 'will give you some tips for a help request (e.g. "/pithy help")' do

      post '/api/v1/slack', params: {
        token: ENV.fetch('SLACK_TOKENS'),
        "command"=>"/pithy",
        "text"=>"help",
        "user_name"=>"someone"
      }
      expect(response).to be_success
      expect(response.body).to eq('{"response_type":"ephemeral","text":"*How to use /pithy*","attachments":[{"color":"#36a64f","text":"Hi @someone! To get started, just type `/pithy` plus the name of an esteemed leader.\n\n For example, `/pithy trump` will return a wonderful quote from Donald Trump, such as \'Unbelievable. Unbelievable.\'\n\n Isn\'t that unbelievable?!","mrkdwn_in":["text"]}]}')

    end

  end

  context 'For an incomplete requests, it' do

    it 'handles empty nicknames (e.g. "/pithy")' do

      post '/api/v1/slack', params: {
        token: ENV.fetch('SLACK_TOKENS'),
        "user_name"=>"someone",
        "command"=>"/pithy",
        "text"=>""
      }
      expect(response).to be_success
      expect(response.body).to eq('{"response_type":"ephemeral","text":"Hello @someone, this is Pithy! Please tell me which esteemed leader you are looking for (e.g. `/pithy trump`)"}')

    end

    it 'handles invalid names (e.g. "/pithy doodle")' do

      post '/api/v1/slack', params: {
        token: ENV.fetch('SLACK_TOKENS'),
        "user_name"=>"someone",
        "command"=>"/pithy",
        "text"=>"doodle"
      }
      expect(response).to be_success
      expect(response.body).to eq('{"response_type":"ephemeral","text":"Oops. Sorry @someone, I couldn\'t find that person. Try again! (e.g. `/pithy trump`)"}')

    end

  end

end
