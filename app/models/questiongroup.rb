class Questiongroup < ApplicationRecord
  belongs_to :survey, foreign_key: 'survey_id'
  has_many :questions, dependent: :destroy
end
