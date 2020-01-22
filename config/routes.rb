Rails.application.routes.draw do
  get 'cards/erdnuss'
  get 'cards/foo'
  get 'cards/bar'
  root to: 'visitors#index'
  devise_for :users
end
