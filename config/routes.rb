Rails.application.routes.draw do
  get 'reservations/confirm'
  get 'rooms/own'
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

  resources :rooms
  
  resources :reservations do
    collection do
      post :confirm
    end
  end
end
