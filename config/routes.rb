Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]

  resources :users, only: %i[new create]

  root to: 'surveys#index'
  resources :surveys do
    resources :question_groups do
      resources :questions do
        resources :answers
      end
    end
  end

  namespace :admin do
    resources :users, only: %i[index create edit update destroy]
  end
end
