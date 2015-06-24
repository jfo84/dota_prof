class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name, presence: true
      t.index :name, unique: true
      t.string :real_name, presence: true
      t.integer :account_id

      t.timestamps null: false
    end
  end
end
