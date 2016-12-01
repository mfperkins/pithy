class CreateSlackTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_teams do |t|
      t.string :team_id
      t.text :team_name
      t.string :channel_name
      t.string :channel_id
      t.text :url
      t.text :configuration_url
      t.string :token
      t.string :scope
      t.string :state
    end
  end
end
