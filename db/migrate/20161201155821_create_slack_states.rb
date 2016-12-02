class CreateSlackStates < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_states do |t|
      t.string :state
    end
  end
end
