class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.text :content, presence: true
      t.boolean :sub_in_review, default: true

      t.timestamps null: false
    end
  end
end
