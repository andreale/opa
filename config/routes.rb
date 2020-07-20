Rails.application.routes.draw do
  get 'cards/erdnuss'
  get 'cards/well_com'
  get 'cards/weather'
  root to: 'visitors#index'
  devise_for :users
end
