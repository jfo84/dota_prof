class CreatePlayerMatches < ActiveRecord::Migration
  def change
    create_table :player_matches do |t|
      t.integer :account_id, presence: true
      t.integer :hero_id, presence: true
      t.integer :kills, presence: true
      t.integer :deaths, presence: true
      t.integer :assists, presence: true
      t.integer :gpm, presence: true
      t.integer :xpm, presence: true
      t.integer :hero_damage, presence: true
      t.integer :tower_damage, presence: true
      t.integer :last_hits, presence: true
      t.integer :denies, presence: true
      t.string :inventory, array: true, default: [], presence: true
      t.boolean :radiant, default: false
      t.boolean :radiant_win, presence: true
      t.integer :start_time, presence: true
      t.integer :match_id, presence: true

      t.timestamps null: false
    end
  end
end
