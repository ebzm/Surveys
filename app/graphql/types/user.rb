# frozen_string_literal: true

module Types
  class AccountTypes < Types::BaseEnum
    value 'EMPLOYEE', value: 'employee'
    value 'EMPLOYER', value: 'employer'
    value 'ADMIN', value: 'admin'
  end

  class User < Types::BaseObject
    implements Interfaces::Timestamps

    field :email, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :age, Integer
    field :password_digest, String, null: false
    field :account_type, AccountTypes, null: false
    field :answers, [Types::Answer], null: true
  end
end
