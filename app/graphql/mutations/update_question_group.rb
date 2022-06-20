# frozen_string_literal: true

module Mutations
  class UpdateQuestionGroup < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :label, String, required: true

    field :question_group, Types::QuestionGroup, null: true
    field :errors, [String], null: true

    def resolve(id:, label:)
      # unless context[:current_user].admin?
      #   raise GraphQL::ExecutionError,
      #         "You need to log in as admin to perform this action"
      # end

      question_group = QuestionGroup.find(id)

      if question_group.update(label: label)
        { question_group: question_group }
      else
        { errors: question_group.errors.full_messages }
      end
    end
  end
end
