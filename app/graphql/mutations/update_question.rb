class Mutations::UpdateQuestion < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :questiontype, String, required: true

  field :question, Types::QuestionType, null: true
  field :errors, [String], null: true

  def resolve(id:, questiontype:)
    # if context[:current_user].admin?
    #   raise GraphQL::ExecutionError,
    #         "You need to log in as admin to perform this action"
    # end

    question = Question.find(id)

    if question.update(questiontype: questiontype)
      { question: question }
    else
      { errors: question.errors.full_messages }
    end
  end
end