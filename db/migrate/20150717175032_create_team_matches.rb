class CreateTeamMatches < ActiveRecord::Migration
  def change
    create_table :team_matches do |t|
      t.string :team_name, presence: true
      t.integer :team_id, presence: true
      t.integer :league_id, presence: true
      t.integer :match_id, presence: true
      t.integer :start_time, presence: true
      t.integer :duration, presence: true
      t.integer :first_blood, presence: true
      t.boolean :radiant, presence: true
      t.boolean :radiant_win, presence: true
      t.integer :captain_id
      t.integer :picks, array: true, default: []
      t.integer :bans, array: true, default: []

      t.timestamps null: false
    end
  end
end
