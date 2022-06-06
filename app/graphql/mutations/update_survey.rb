class Mutations::UpdateSurvey < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :label, String, required: true

  field :survey, Types::SurveyType, null: true
  field :errors, [String], null: true

  def resolve(id:, label:)
    # if context[:current_user].admin?
    #   raise GraphQL::ExecutionError,
    #         "You need to log in as admin to perform this action"
    # end

    survey = Survey.find(id)

    if survey.update(label: label)
      { survey: survey }
    else
      { errors: survey.errors.full_messages }
    end
  end
end