class AddPlayerIdToPlayerMatches < ActiveRecord::Migration
  def change
    add_column :player_matches, :player_id, :integer
  end
end
