Rails.application.routes.draw do
  resources :cards, only: %i[index]
  root 'cards#index'
end
