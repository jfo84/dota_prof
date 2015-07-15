class AddTeamIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :team_id, :integer
  end
end
