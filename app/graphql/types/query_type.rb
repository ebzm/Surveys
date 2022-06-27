# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField

    # /users
    field :users, [Types::User], null: false do
      argument :sort, [Sorting::User::Input], required: false,
                                              default_value: [{ first_name: 'ASC' }, { last_name: 'ASC' }]
      argument :first_name, String, required: false
      argument :last_name, String, required: false
    end

    def users(first_name: nil, last_name: nil, sort: [])
      scope = ::User.all

      scope = Filtering::Field.filter_by_fields(scope: scope, fields: {
                                                  first_name: first_name,
                                                  last_name: last_name
                                                })

      Sorting::User.sort_with(scope, sort)
      binding.pry
    end

    # /surveys
    field :surveys, [Types::Survey], null: false do
      argument :sort, [Sorting::Survey::Input], required: false
    end

    def surveys(sort: [])
      scope = ::Survey.all

      Sorting::Survey.sort_with(scope, sort)
    end

    # /question_groups
    field :question_groups, [Types::QuestionGroup], null: false do
      argument :sort, [Sorting::QuestionGroup::Input], required: false,
                                                       default_value: [{ label: 'ASC' }]
    end

    def question_groups(sort: [])
      scope = ::QuestionGroup.all

      Sorting::Survey.sort_with(scope, sort)
    end

    # /questions
    field :questions, [Types::Question], null: false do
      argument :sort, [Sorting::Question::Input], required: false,
                                                  default_value: [{ questiontype: 'ASC' }]
    end

    def questions(sort: [])
      scope = ::Question.all

      Sorting::Survey.sort_with(scope, sort)
    end

    # /answers
    field :answers, [Types::Answer], null: false do
      argument :val, Float, required: false
      argument :min, Float, required: false
      argument :max, Float, required: false
    end

    def answers(val: nil, min: nil, max: nil)
      scope = ::Answer.all

      scope = Filtering::Field.filter_by_fields(scope: scope, fields: { answer_val: val })
      Filtering::Interval.filter_by_interval(scope: scope, indicator: 'answer_val', min: min, max: max)
    end
  end
end
