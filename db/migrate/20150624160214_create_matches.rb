class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.jsonb :payload, presence: true

      t.timestamps null: false
    end
  end
end
