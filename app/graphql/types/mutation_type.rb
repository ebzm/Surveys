# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_survey, mutation: Mutations::CreateSurvey
    field :create_question_group, mutation: Mutations::CreateQuestionGroup
    field :create_question, mutation: Mutations::CreateQuestion
    field :create_answer, mutation: Mutations::CreateAnswer

    field :update_survey, mutation: Mutations::UpdateSurvey
    field :update_question_group, mutation: Mutations::UpdateQuestionGroup
    field :update_question, mutation: Mutations::UpdateQuestion
    field :update_answer, mutation: Mutations::UpdateAnswer
    field :update_user, mutation: Mutations::UpdateUser

    field :destroy_survey, mutation: Mutations::DestroySurvey
  end
end
