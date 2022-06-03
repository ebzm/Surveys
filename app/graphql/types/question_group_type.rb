# frozen_string_literal: true

module Types
  class QuestionGroupType < Types::BaseObject
    field :id, ID, null: false
    field :label, String
    field :survey_id, Integer
    field :questions, [Types::QuestionType], null: true
  end
end
