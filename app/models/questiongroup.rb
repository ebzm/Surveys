class Questiongroup < ApplicationRecord
  belongs_to :survey, foreign_key: 'survey_id'
end
