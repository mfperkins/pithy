require 'rails_helper'

describe "Slack API" do

  it 'Post gives you the right quote' do

    Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
    Quote.create(text: "Unbelievable. Unbelievable.", person_id: Person.last.id)

    post '/api/v1/slack', params: {
      token: ENV.fetch('SLACK_TOKENS'),
      "user_name"=>"mfperkins",
      "command"=>"/pithy",
      "text"=>"trump"
    }

    expect(response).to be_success
    expect(response.body).to eq(
    "{\"attachments\":[{\"fallback\":\"Unbelievable. Unbelievable.\",\"color\":\"#ffb300\",\"title\":\"As Donald Trump would say...\",\"title_link\":\"https://impithy.herokuapp.com/people/trump\",\"fields\":[{\"title\":\"Unbelievable. Unbelievable.\",\"short\":false}],\"footer\":\"posted by mfperkins\"}]}"
    )
  end

end
