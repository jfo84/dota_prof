class User < ActiveRecord::Base
  has_many :submissions

  def admin?
    role == 'admin'
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
