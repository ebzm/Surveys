module Types
  class QueryType < Types::BaseObject
    # /users
    field :users, [Types::User], null: false

    def users
      ::User.all
    end

    field :user, Types::User, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      ::User.find(id)
    end

    # /surveys
    field :surveys, [Types::Survey], null: false

    def surveys
      ::Survey.all
    end

    field :survey, Types::Survey, null: false do
      argument :id, ID, required: true
    end

    def survey(id:)
      ::Survey.find(id)
    end

    # /question_groups
    field :question_groups, [Types::QuestionGroup], null: false

    def question_groups
      ::QuestionGroup.all
    end

    field :question_group, Types::QuestionGroup, null: false do
      argument :id, ID, required: true
    end

    def question_group(id:)
      ::QuestionGroup.find(id)
    end

    # /questions
    field :questions, [Types::Question], null: false

    def questions
      ::Question.all
    end

    field :question, Types::Question, null: false do
      argument :id, ID, required: true
    end

    def question(id:)
      ::Question.find(id)
    end

    # /answers
    field :answers, [Types::Answer], null: false

    def answers
      ::Answer.all
    end

    field :answer, Types::Answer, null: false do
      argument :id, ID, required: true
    end

    def answer(id:)
      ::Answer.find(id)
    end
  end
end
