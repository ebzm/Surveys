Rails.application.routes.draw do
  resources :surveys
  resources :questiongroups
  resources :questions
end
