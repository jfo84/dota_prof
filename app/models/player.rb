class Player < ActiveRecord::Base
  belongs_to :team
  has_many :submissions
  has_many :player_matches

  validates :account_id, presence: true
end
