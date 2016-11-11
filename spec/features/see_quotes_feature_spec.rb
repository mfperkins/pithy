require 'rails_helper'

feature 'See all quotes from a person' do

  let(:trump) { Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump") }
  let(:quote) { Quote.create(text: "hello", person_id: trump.id)}

  context 'User logged in' do

    before(:each) do
      puts trump.inspect
      puts quote.inspect
      puts Quote.create(text: "Unbelieveable. Unbelievable.", person_id: trump.id).inspect
    end

    scenario 'User can click on a name and see all quotes' do
      visit '/'
      click_on("Donald Trump")
      puts page.body
      expect(page).to have_content "Unbelieveable. Unbelieveable."
    end

  end

end
