Rails.application.routes.draw do
  get 'reservations/confirm'
  get 'reservations/index'
  get 'rooms/own'
  get 'rooms/index'
  get 'users/account'
  get 'users/profile'
  get 'users/profile/edit' => 'users#edit'
  patch 'users/profile/:id'  => 'users#update'
  root 'top_pages#top'
  get 'top_pages/top'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # devise_scope :user do
  #   get 'users/show' => 'users/registrations#show'
  # end

  resources :rooms do
    collection do
      get 'search'
    end
  end
  
  resources :reservations do
    collection do
      post :confirm
    end
  end
end
