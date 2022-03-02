Rails.application.routes.draw do
  get 'pairing_requests/create'
  get 'pairing_requests/destroy'
  devise_for :users
  root to: 'pages#home'
  resources :chats, only: [:show, :create, :index] do
    resources :messages, only: :create
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :pairing_sessions, only: %i[index new create] do
    resources :pairing_requests, only: %i[index create]
  end

  get "/myprofile", to: "profiles#show", as: :my_profile
  patch "/myprofile", to: "profiles#update"
  get "/myprofile/edit", to: "profiles#edit", as: :edit_my_profile
end
