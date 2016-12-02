class RemoveStateFromTeams < ActiveRecord::Migration[5.0]
  def change
    remove_column :teams, :state, :string
  end
end
