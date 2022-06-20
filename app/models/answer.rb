# frozen_string_literal: true

class Answer < ApplicationRecord
  include Hashid::Rails

  belongs_to :question
  belongs_to :user
end
