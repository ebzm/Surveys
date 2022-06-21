# frozen_string_literal: true

module Mutations
  class UpdateQuestion < Mutations::BaseMutation
    argument :question_id, ID, loads: Types::Question, required: true
    argument :questiontype, String, required: true

    field :question, Types::Question, null: true
    field :errors, [String], null: true

    def resolve(question:, questiontype:)
      # unless context[:current_user].admin?
      #   raise GraphQL::ExecutionError,
      #         "You need to log in as admin to perform this action"
      # end

      if question.update(questiontype: questiontype)
        { question: question }
      else
        { errors: question.errors.full_messages }
      end
    end
  end
end
