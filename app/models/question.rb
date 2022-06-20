# frozen_string_literal: true

class Question < ApplicationRecord
  include Hashid::Rails

  belongs_to :question_group
  has_many :answers, dependent: :destroy
end
