Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]

  resources :users, only: %i[new create]

  root to: 'surveys#index'
  resources :surveys
  resources :questiongroups
  resources :questions
end
