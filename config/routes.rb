Rails.application.routes.draw do
  get 'pairing_requests/create'
  get 'pairing_requests/destroy'
  devise_for :users
  root to: 'pages#home'
  resources :chats, only: [:show, :create, :index] do
    resources :messages, only: :create
  end
  resources :pairing_requests, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :pairing_sessions, only: %i[index new create] do
    resources :pairing_requests, only: %i[create]
  end
  get "profile/edit", to: "pages#edit", as: :edit_my_profile
  get "profile/:id", to: "pages#profile", as: :my_profile
  patch "profile/:id", to: "pages#update"
end
