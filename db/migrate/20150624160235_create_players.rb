class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name, presence: true
      t.integer :account_id, presence: true

      t.timestamps null: false
    end
  end
end
