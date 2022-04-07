class Survey < ApplicationRecord
  has_many :question_groups, dependent: :destroy
end
