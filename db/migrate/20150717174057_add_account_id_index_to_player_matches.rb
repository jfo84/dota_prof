class AddAccountIdIndexToPlayerMatches < ActiveRecord::Migration
  def change
    add_index :player_matches, :account_id
  end
end
