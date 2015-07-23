class Player < ActiveRecord::Base
  belongs_to :team
  has_many :submissions

  validates :account_id, presence: true
end
