class AddPersonToQuote < ActiveRecord::Migration[5.0]
  def change
    add_reference :quotes, :person, foreign_key: true
  end
end
