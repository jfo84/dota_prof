class AddIdRosterToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :id_roster, :string, array: true, default: []
  end
end
