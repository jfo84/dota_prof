class AddTeamIdIndexToTeamMatches < ActiveRecord::Migration
  def change
    add_index :team_matches, :team_id
  end
end
