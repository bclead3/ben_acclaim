Rails.application.routes.draw do
  resources :heroes
  resources :organizations

  root 'organizations#index'
end
