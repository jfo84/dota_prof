class Player < ActiveRecord::Base
  belongs_to :team

  validates :name, presence: true, uniqueness: true
  validates :real_name, presence: true
end
