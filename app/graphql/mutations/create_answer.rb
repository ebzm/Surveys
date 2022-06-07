class Mutations::CreateAnswer < Mutations::BaseMutation
  argument :answer_val, Float, required: true
  argument :question_id, ID, required: true

  field :answer, Types::AnswerType, null: true
  field :errors, [String], null: true

  def resolve(answer_val:, question_id:)
    # unless context[:current_user].admin?
    #   raise GraphQL::ExecutionError,
    #         "You need to log in as admin to perform this action"
    # end

    question = Question.find(question_id)
    answer = question.answers.build(answer_val: answer_val, user_id: context[:current_user].id)

    if answer.save
      { answer: answer }
    else
      { errors: answer.errors.full_messages }
    end
  end
end