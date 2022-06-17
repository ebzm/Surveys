# frozen_string_literal: true

module Types
  class Survey < Types::BaseRecordObject
    implements Interfaces::Timestamps

    field :label, String

    field :question_groups, [QuestionGroup], null: true
    def question_groups
      defer_load_has_many(::QuestionGroup, :survey, object)
    end
  end
end
