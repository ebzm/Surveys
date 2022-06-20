# frozen_string_literal: true

module Mutations
  class DestroySurvey < Mutations::BaseMutation
    argument :id, ID, required: true

    field :survey, Types::Survey, null: true
    field :errors, [String], null: true

    def resolve(id:)
      # unless context[:current_user].admin?
      #   raise GraphQL::ExecutionError,
      #         "You need to log in as admin to perform this action"
      # end

      survey = Survey.find(id)
      survey.destroy
    end
  end
end
