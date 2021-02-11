Rails.application.routes.draw do
  resources :opinions
  resources :followings
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "opinions#index"
end
