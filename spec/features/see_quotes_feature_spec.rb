require 'rails_helper'

feature 'See all quotes from a person' do

  before(:each) do
    Person.create(first_name: "Donald", last_name: "Trump", nickname: "trump")
    Quote.create(text: "Unbelieveable. Unbelievable.", person_id: Person.last.id)
  end

  context 'User logged in' do

    scenario 'User can click on a name and see all quotes' do
      visit '/'
      click_on("Donald Trump")
      expect(page.body).to have_content "Pithy Donald Trump // Quotes Add quote Quote Unbelieveable. Unbelievable."
    end

  end

end
