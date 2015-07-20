class AddGinIndexToMatches < ActiveRecord::Migration
  def change
    add_index :matches, :payload, using: :gin
  end
end
