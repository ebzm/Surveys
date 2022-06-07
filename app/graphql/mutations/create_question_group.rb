class Mutations::CreateQuestionGroup < Mutations::BaseMutation
  argument :label, String, required: true
  argument :survey_id, ID, required: true

  field :question_group, Types::QuestionGroup, null: true
  field :errors, [String], null: true

  def resolve(label:, survey_id:)
    # unless context[:current_user].admin?
    #   raise GraphQL::ExecutionError,
    #         "You need to log in as admin to perform this action"
    # end

    survey = Survey.find(survey_id)
    question_group = survey.question_groups.build(label: label)

    if question_group.save
      { question_group: question_group }
    else
      { errors: question_group.errors.full_messages }
    end
  end
end