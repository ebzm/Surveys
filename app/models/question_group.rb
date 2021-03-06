# frozen_string_literal: true

class QuestionGroup < ApplicationRecord
  include Hashid::Rails

  belongs_to :survey
  has_many :questions, dependent: :destroy
end
