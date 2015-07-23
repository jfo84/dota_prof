class AddUserAndPlayerIdsToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :user_id, :integer
    add_column :submissions, :player_id, :integer
  end
end
