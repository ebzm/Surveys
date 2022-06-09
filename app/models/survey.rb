class Survey < ApplicationRecord
  include Hashid::Rails
  
  has_many :question_groups, dependent: :destroy
end
