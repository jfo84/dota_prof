class Match < ActiveRecord::Base
  has_many :teams
  has_many :players, through: :teams

  validates :payload, presence: true
end
