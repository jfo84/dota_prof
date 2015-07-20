class AddAccountIdIndexToPlayers < ActiveRecord::Migration
  def change
    add_index :players, :account_id, unique: true
  end
end
