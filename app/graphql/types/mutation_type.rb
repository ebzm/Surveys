module Types
  class MutationType < Types::BaseObject
    field :update_survey, mutation: Mutations::UpdateSurvey
    field :update_question_group, mutation: Mutations::UpdateQuestionGroup
    field :update_question, mutation: Mutations::UpdateQuestion
    field :update_answer, mutation: Mutations::UpdateAnswer
    field :update_user, mutation: Mutations::UpdateUser
  end
end
