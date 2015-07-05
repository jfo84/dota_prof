class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, presence: true
      t.index :name, unique: true
      t.string :roster, array: true, default: []
      t.boolean :top_50, presence: true, default: false


      t.timestamps null: false
    end
  end
end
