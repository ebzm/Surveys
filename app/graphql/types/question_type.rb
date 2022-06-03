# frozen_string_literal: true

module Types
  class QuestionType < Types::BaseObject
    field :id, ID, null: false
    field :questiontype, String
    field :question_group_id, Integer
    field :answers, [Types::AnswerType], null: true
  end
end
