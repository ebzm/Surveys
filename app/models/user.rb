class User < ApplicationRecord
  enum account_type: { employee: 0, employer: 1, admin: 2 }
  has_many :answers, dependent: :destroy

  has_secure_password
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :account_type, presence: true
end
