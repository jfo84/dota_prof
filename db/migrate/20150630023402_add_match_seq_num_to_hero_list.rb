class AddMatchSeqNumToHeroList < ActiveRecord::Migration
  def change
    add_column :hero_lists, :match_seq_num, :integer
  end
end
