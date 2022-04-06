class Question < ApplicationRecord
  belongs_to :questiongroup, foreign_key: 'questiongroup_id'
  has_many :answers, dependent: :destroy
end
