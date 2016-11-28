require 'rails_helper'

describe "Quotes API" do

  it 'GET gives you all the quotes' do

    Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
    Quote.create(text: "Unbelievable. Unbelievable.", person_id: Person.last.id)

    get '/api/v1/people/trump/quotes'

    expect(response).to be_success
    expect(response.body).to eq("Unbelievable. Unbelievable.")
  end
  
end
