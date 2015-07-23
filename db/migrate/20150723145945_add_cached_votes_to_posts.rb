class AddCachedVotesToPosts < ActiveRecord::Migration
  def self.up
    add_column :submissions, :cached_votes_total, :integer, :default => 0
    add_column :submissions, :cached_votes_score, :integer, :default => 0
    add_column :submissions, :cached_votes_up, :integer, :default => 0
    add_column :submissions, :cached_votes_down, :integer, :default => 0
    add_index  :submissions, :cached_votes_total
    add_index  :submissions, :cached_votes_score
    add_index  :submissions, :cached_votes_up
    add_index  :submissions, :cached_votes_down

    Submission.find_each(&:update_cached_votes)
  end

  def self.down
    remove_column :submissions, :cached_votes_total
    remove_column :submissions, :cached_votes_score
    remove_column :submissions, :cached_votes_up
    remove_column :submissions, :cached_votes_down
  end
end
