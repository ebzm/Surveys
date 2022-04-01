Rails.application.routes.draw do
  resources :surveys
  resources :questiongroups
  get '/surveys/1', to: 'surveys#show'
end
