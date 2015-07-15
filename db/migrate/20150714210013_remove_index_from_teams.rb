class RemoveIndexFromTeams < ActiveRecord::Migration
  def change
    remove_index :teams, :name
  end
end
