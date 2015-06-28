class Player < ActiveRecord::Base
  belongs_to :team

  validates :name, presence: true, uniqueness: true
  validates :account_id, presence: true
end
