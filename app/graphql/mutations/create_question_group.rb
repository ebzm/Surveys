# frozen_string_literal: true

module Mutations
  class CreateQuestionGroup < Mutations::BaseMutation
    argument :label, String, required: true
    argument :survey_id, ID, loads: Types::Survey, required: true

    field :question_group, Types::QuestionGroup, null: true
    field :errors, [String], null: true

    def resolve(label:, survey:)
      # unless context[:current_user].admin?
      #   raise GraphQL::ExecutionError,
      #         "You need to log in as admin to perform this action"
      # end
      
      question_group = survey.question_groups.build(label: label)

      if question_group.save
        { question_group: question_group }
      else
        { errors: question_group.errors.full_messages }
      end
    end
  end
end
