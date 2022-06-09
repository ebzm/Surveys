# frozen_string_literal: true

module Types
  class Survey < Types::BaseObject
    implements Interfaces::Timestamps

    # field :id, ID, null: false
    field :label, String
    global_id_field :id

    field :question_groups, [QuestionGroup], null: true
    def question_groups
      defer_load_has_many(::QuestionGroup, :survey, object)
    end
  end
end
