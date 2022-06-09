# frozen_string_literal: true

module Types
  class QuestionGroup < Types::BaseObject
    # field :id, ID, null: false
    field :label, String
    field :survey_id, Integer
    global_id_field :id

    field :questions, [Question], null: true
    def questions
      defer_load_has_many(::Question, :question_group, object)
    end

    field :survey, Survey, null: true
    def survey
      defer_batch_load(::Survey, object.survey_id)
    end
  end
end
