class Player < ActiveRecord::Base
  belongs_to :team

  validates :account_id, presence: true
end
