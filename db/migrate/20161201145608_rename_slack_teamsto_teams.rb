class RenameSlackTeamstoTeams < ActiveRecord::Migration[5.0]
  def change
    rename_table :slack_teams, :teams
  end
end
