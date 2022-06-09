# frozen_string_literal: true

module Types
  class Answer < Types::BaseObject
    implements Interfaces::Timestamps

    # field :id, ID, null: false
    field :answer_val, Float, null: false
    field :question_id, Integer, null: false
    field :user_id, Integer, null: false
    global_id_field :id

    field :user, User, null: true
    def user
      defer_batch_load(::User, object.user_id)
    end

    field :question, Question, null: true
    def question
      defer_batch_load(::Question, object.question_id)
    end
  end
end