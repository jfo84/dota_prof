class AddTeamIdIndexToTeams < ActiveRecord::Migration
  def change
    add_index :teams, :team_id, unique: true
  end
end
