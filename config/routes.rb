Rails.application.routes.draw do
  get 'cards/erdnuss'
  get 'cards/weather'
  get 'cards/foobar'
  root to: 'visitors#index'
  devise_for :users
end
