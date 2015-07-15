class AddMatchIdToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :match_id, :integer
  end
end
