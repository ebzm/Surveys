class Mutations::UpdateAnswer < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :answer_val, Float, required: true

  field :answer, Types::Answer, null: true
  field :errors, [String], null: true

  def resolve(id:, answer_val:)
    # unless context[:current_user].admin?
    #   raise GraphQL::ExecutionError,
    #         "You need to log in as admin to perform this action"
    # end

    answer = Answer.find(id)

    if answer.update(answer_val: answer_val)
      { answer: answer }
    else
      { errors: answer.errors.full_messages }
    end
  end
end