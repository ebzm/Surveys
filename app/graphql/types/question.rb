# frozen_string_literal: true

module Types
  class Question < Types::BaseObject
    field :id, ID, null: false
    field :questiontype, String
    field :question_group_id, Integer
    field :answers, [Types::Answer], null: true
  end
end
