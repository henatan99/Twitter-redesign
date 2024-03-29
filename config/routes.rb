Rails.application.routes.draw do
  resources :opinions
  resources :followings
  # devise_for :users
  resources :users do
    member do 
      get 'follow'
      get 'unfollow'
      get 'upload_photo'
      get 'upload_cover'  
      get 'following'
      get 'followers'  
    end 
  end 
  resources :sessions, only: %i[new create show destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "opinions#index"
end
