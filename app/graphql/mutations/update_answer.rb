# frozen_string_literal: true

module Mutations
  class UpdateAnswer < Mutations::BaseMutation
    argument :answer_id, ID, loads: Types::Answer, required: true
    argument :answer_val, Float, required: true

    field :answer, Types::Answer, null: true
    field :errors, [String], null: true

    def resolve(answer:, answer_val:)
      # unless context[:current_user].admin?
      #   raise GraphQL::ExecutionError,
      #         "You need to log in as admin to perform this action"
      # end

      if answer.update(answer_val: answer_val)
        { answer: answer }
      else
        { errors: answer.errors.full_messages }
      end
    end
  end
end
