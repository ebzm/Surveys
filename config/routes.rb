Rails.application.routes.draw do
  root to: 'surveys#index'
  resources :surveys
  resources :questiongroups
  resources :questions
end
