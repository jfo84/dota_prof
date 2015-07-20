class AddMatchIdIndexToMatches < ActiveRecord::Migration
  def change
    add_index :matches, :match_id, unique: true
  end
end
