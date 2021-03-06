# frozen_string_literal: true

module Mutations
  class CreateAnswer < Mutations::BaseMutation
    argument :answer_val, Float, required: true
    argument :question_id, ID, loads: Types::Question, required: true

    field :answer, Types::Answer, null: true
    field :errors, [String], null: true

    def resolve(answer_val:, question:)
      # unless context[:current_user].admin?
      #   raise GraphQL::ExecutionError,
      #         "You need to log in as admin to perform this action"
      # end

      answer = question.answers.build(answer_val: answer_val, user_id: context[:current_user].id)

      if answer.save
        { answer: answer }
      else
        { errors: answer.errors.full_messages }
      end
    end
  end
end
