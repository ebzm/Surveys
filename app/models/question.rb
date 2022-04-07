class Question < ApplicationRecord
  belongs_to :questiongroup
  has_many :answers, dependent: :destroy
end
