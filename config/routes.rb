Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :chats, only: [:show, :create, :index] do
    resources :messages, only: :create
  end
end
