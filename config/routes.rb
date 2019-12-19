Rails.application.routes.draw do

  devise_for :users

  resources :books
  resources :users, only: [:index, :show, :edit, :update]

  root 'homes#home'
  get 'home/about' => 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
