# frozen_string_literal: true

module Mutations
  class UpdateQuestionGroup < Mutations::BaseMutation
    argument :question_group_id, ID, loads: Types::QuestionGroup, required: true
    argument :label, String, required: true

    field :question_group, Types::QuestionGroup, null: true
    field :errors, [String], null: true

    def resolve(question_group:, label:)
      return unless guard_by_policy('QuestionGroupPolicy', 'update?')

      if question_group.update(label: label)
        { question_group: question_group }
      else
        { errors: question_group.errors.full_messages }
      end
    end
  end
end
