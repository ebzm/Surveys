# frozen_string_literal: true

module Types
  class Question < Types::BaseObject
    field :questiontype, String
    field :question_group_id, Integer

    field :answers, [Answer], null: true
    def answers
      defer_load_has_many(::Answer, :question, object)
    end

    field :question_group, QuestionGroup, null: true
    def question_group
      defer_batch_load(::QuestionGroup, object.question_group_id)
    end
  end
end
