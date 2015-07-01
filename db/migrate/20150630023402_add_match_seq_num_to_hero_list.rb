class AddStartTimeToHeroList < ActiveRecord::Migration
  def change
    add_column :hero_lists, :start_time, :integer
  end
end
