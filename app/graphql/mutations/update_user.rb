# frozen_string_literal: true

module Mutations
  class UpdateUser < Mutations::BaseMutation
    argument :user_id, ID, loads: Types::User, required: true
    argument :email, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :age, Integer, required: true

    field :user, Types::User, null: true
    field :errors, [String], null: true

    def resolve(user:, email:, first_name:, last_name:, age:)
      if user.update(email: email, first_name: first_name, last_name: last_name, age: age)
        { user: user }
      else
        { errors: user.errors.full_messages }
      end
    end
  end
end
