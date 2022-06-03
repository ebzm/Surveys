module Types
  class QueryType < Types::BaseObject
    # /users
    field :users, [Types::UserType], null: false

    def users
      User.all
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    # /surveys
    field :surveys, [Types::SurveyType], null: false

    def surveys
      Survey.all
    end

    field :survey, Types::SurveyType, null: false do
      argument :id, ID, required: true
    end

    def survey(id:)
      Survey.find(id)
    end

    # /question_groups
    field :question_groups, [Types::QuestionGroupType], null: false

    def question_groups
      QuestionGroup.all
    end

    field :question_group, Types::QuestionGroupType, null: false do
      argument :id, ID, required: true
    end

    def question_group(id:)
      QuestionGroup.find(id)
    end

    # /questions
    field :questions, [Types::QuestionType], null: false

    def questions
      Question.all
    end

    field :question, Types::QuestionType, null: false do
      argument :id, ID, required: true
    end

    def question(id:)
      Question.find(id)
    end

    # /answers
    field :answers, [Types::AnswerType], null: false

    def answers
      Answer.all
    end

    field :answer, Types::AnswerType, null: false do
      argument :id, ID, required: true
    end

    def answer(id:)
      Answer.find(id)
    end
  end
end
