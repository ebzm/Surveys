class Mutations::UpdateUser < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :email, String, required: true
  argument :first_name, String, required: true
  argument :last_name, String, required: true
  argument :age, Integer, required: true

  field :user, Types::UserType, null: true
  field :errors, [String], null: true

  def resolve(id:, email:, first_name:, last_name:, age:)
    user = User.find(id)

    if user.update(email: email, first_name: first_name, last_name: last_name, age: age)
      { user: user }
    else
      { errors: user.errors.full_messages }
    end
  end
end