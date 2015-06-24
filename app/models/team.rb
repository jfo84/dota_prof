class Team < ActiveRecord::Base
  has_many :players
  has_many :matches

  validates :name, presence: true
  validates :roster, presence: true
end
