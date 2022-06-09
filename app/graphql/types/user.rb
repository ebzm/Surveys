# frozen_string_literal: true

module Types
  class User < Types::BaseObject
    implements Interfaces::Timestamps

    # field :id, ID, null: false
    global_id_field :id
    field :email, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :age, Integer
    field :password_digest, String, null: false
    field :account_type, Integer, null: false
    field :answers, [Types::Answer], null: true
  end
end
