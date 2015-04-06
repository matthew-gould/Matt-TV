Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  root "application#home"

  resources :shows, only: [:show, :index]
  
  resources :favorites, only: [:create, :index, :destroy]

  get 'profile/:user_id'       => 'profiles#show'
  post 'profile/;user_id'      => 'profiles#update'
  get 'profile/:user_id/edit'  => 'profiles#edit'

end
