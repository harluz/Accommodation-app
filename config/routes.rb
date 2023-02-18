Rails.application.routes.draw do
  get 'reservations/confirm'
  get 'reservations/index'
  get 'rooms/own'
  get 'rooms/index'
  get 'users/account' #仮実装のルーティング
  get 'users/profile'
  get 'users/profile/:id/edit' => 'users#edit' #仮実装のルーティング
  patch 'users/profile/:id'  => 'users#update' #仮実装のルーティング
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
