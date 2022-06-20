# frozen_string_literal: true

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql#execute' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'

  resource :session, only: %i[new create destroy]

  resources :users, only: %i[new create]

  root to: 'surveys#index'
  resources :surveys do
    resources :question_groups
  end
  resources :questions do
    resources :answers
  end

  namespace :admin do
    resources :users, only: %i[index create edit update destroy]
  end
end
