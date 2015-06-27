class CreateHeroLists < ActiveRecord::Migration
  def change
    create_table :hero_lists do |t|
      t.integer :account_id, presence: true
      t.integer :hero_id, presence: true

      t.timestamps null: false
    end
  end
end
