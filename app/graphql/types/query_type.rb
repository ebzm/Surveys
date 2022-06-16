module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    
    field :node, [GlobalId] do
      argument :id, ID
    end
    
    def node(id:)
      ::SurveysSchema.object_from_id(id)
    end
    
    # /users
    field :users, [Types::User], null: false do
      argument :sort, [Sorting::User::Input], required: false,
        default_value: [{ first_name: "ASC" }, { last_name: "ASC" }]
    end

    def users(sort: [])
      scope = ::User.all

      scope = Sorting::User.sort_with(scope, sort)
      scope
    end

    field :user, Types::User, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      ::User.find(id)
    end

    # /surveys
    field :surveys, [Types::Survey], null: false do
      argument :sort, [Sorting::Survey::Input], required: false
    end

    def surveys(sort: [])
      scope = ::Survey.all

      scope = Sorting::Survey.sort_with(scope, sort)
      scope
    end

    field :survey, Types::Survey, null: false do
      argument :id, ID, required: true
    end

    def survey(id:)
      ::Survey.find(id)
    end

    # /question_groups
    field :question_groups, [Types::QuestionGroup], null: false do
      argument :sort, [Sorting::QuestionGroup::Input], required: false,
        default_value: [{ label: "ASC" }]
    end

    def question_groups(sort: [])
      scope = ::QuestionGroup.all

      scope = Sorting::Survey.sort_with(scope, sort)
      scope
    end

    field :question_group, Types::QuestionGroup, null: false do
      argument :id, ID, required: true
    end

    def question_group(id:)
      ::QuestionGroup.find(id)
    end

    # /questions
    field :questions, [Types::Question], null: false do
      argument :sort, [Sorting::Question::Input], required: false,
        default_value: [{ questiontype: "ASC" }]
    end

    def questions(sort: [])
      scope = ::Question.all

      scope = Sorting::Survey.sort_with(scope, sort)
      scope
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
