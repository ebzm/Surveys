# frozen_string_literal: true

module Mutations
  class CreateSurvey < Mutations::BaseMutation
    argument :label, String, required: true

    field :survey, Types::Survey, null: true
    field :errors, [String], null: true

    def resolve(label:)
      # unless context[:current_user].admin?
      #   raise GraphQL::ExecutionError,
      #         "You need to log in as admin to perform this action"
      # end

      survey = Survey.new(label: label)

      if survey.save
        { survey: survey }
      else
        { errors: survey.errors.full_messages }
      end
    end
  end
end
