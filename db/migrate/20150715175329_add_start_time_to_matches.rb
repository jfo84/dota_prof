class AddStartTimeToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :start_time, :integer
  end
end
