class Survey < ApplicationRecord
  has_many :questiongroups, dependent: :destroy
end
