Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :chats, only: [:show, :create, :index] do
    resources :messages, only: :create
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :pairing_sessions, only: %i[index new create] do
    resources :pairing_requests, only: %i[update]
  end

  resources :pairing_requests, only: %i[index show create]

  get "profile/edit", to: "pages#edit", as: :edit_my_profile
  get "profile/:id", to: "pages#profile", as: :my_profile
  patch "profile/:id", to: "pages#update"
end
