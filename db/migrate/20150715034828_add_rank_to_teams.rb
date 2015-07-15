class AddRankToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :rank, :integer
  end
end
