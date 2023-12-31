class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:user,:admin]
  has_many :reviews, dependent: :destroy
  after_initialize :set_role, if: :new_record?

  def set_role
    self.role ||= :user
  end
end
