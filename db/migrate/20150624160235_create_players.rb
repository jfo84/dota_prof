class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :account_id, presence: true
      t.integer :favorite_hero, presence: true
      t.string :fh_record, presence: true

      t.timestamps null: false
    end
  end
end
