class Question < ApplicationRecord
  belongs_to :questiongroup, foreign_key: 'questiongroup_id'
end
