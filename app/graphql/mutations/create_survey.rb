# frozen_string_literal: true

module Mutations
  class CreateSurvey < Mutations::BaseMutation
    argument :label, String, required: true

    field :survey, Types::Survey, null: true
    field :errors, [String], null: true

    def resolve(label:)
      return unless guard_by_policy('create?')

      survey = Survey.new(label: label)

      if survey.save
        { survey: survey }
      else
        { errors: survey.errors.full_messages }
      end
    end
  end
end
