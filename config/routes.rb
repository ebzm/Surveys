Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]

  resources :users, only: %i[new create]

  root to: 'surveys#index'
  resources :surveys
  resources :question_groups
  resources :questions do
    resources :answers
  end

  namespace :admin do
    resources :users, only: %i[index create edit update destroy]
  end
end
