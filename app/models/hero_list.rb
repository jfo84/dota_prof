class HeroList < ActiveRecord::Base
  belongs_to :player

  validates :account_id, presence: true
  validates :hero_id, presence: true
end
