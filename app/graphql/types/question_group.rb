# frozen_string_literal: true

module Types
  class QuestionGroup < Types::BaseObject
    field :id, ID, null: false
    field :label, String
    field :survey_id, Integer
    field :questions, [Types::Question], null: true
  end
end
