Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql#execute"
  end
  post "/graphql", to: "graphql#execute"

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
