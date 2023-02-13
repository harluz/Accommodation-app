Rails.application.routes.draw do
  get 'rooms/index'
  get 'users/profile'
  root 'top_pages#index'
  get 'top_pages/index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # devise_scope :user do
  #   get 'users/show' => 'users/registrations#show'
  # end

  resources :room
end
