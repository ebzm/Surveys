# frozen_string_literal: true

module Mutations
  class CreateQuestion < Mutations::BaseMutation
    argument :questiontype, String, required: true
    argument :question_group_id, ID, required: true

    field :question, Types::Question, null: true
    field :errors, [String], null: true

    def resolve(questiontype:, question_group_id:)
      # unless context[:current_user].admin?
      #   raise GraphQL::ExecutionError,
      #         "You need to log in as admin to perform this action"
      # end

      question_group = QuestionGroup.find(question_group_id)
      question = question_group.questions.build(questiontype: questiontype)

      if question.save
        { question: question }
      else
        { errors: question.errors.full_messages }
      end
    end
  end
end
