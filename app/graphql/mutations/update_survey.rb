# frozen_string_literal: true

module Mutations
  class UpdateSurvey < Mutations::BaseMutation
    argument :survey_id, ID, loads: Types::Survey, required: true
    argument :label, String, required: true

    field :survey, Types::Survey, null: true
    field :errors, [String], null: true

    def resolve(survey:, label:)
      # unless context[:current_user].admin?
      #   raise GraphQL::ExecutionError,
      #         "You need to log in as admin to perform this action"
      # end

      if survey.update(label: label)
        { survey: survey }
      else
        { errors: survey.errors.full_messages }
      end
    end
  end
end
