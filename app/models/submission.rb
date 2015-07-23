class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :player

  acts_as_votable

  scope :approved, -> {
    where(:sub_in_review => false)
  }
  scope :pending, -> {
    where(:sub_in_review => true)
  }
  scope :newest, -> {
    order("created_at desc")
  }

  validates :content, presence: true
end
