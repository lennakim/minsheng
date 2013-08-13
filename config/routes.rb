Minsheng::Application.routes.draw do
  namespace :admin do
    resources :categories
    resources :shops
  end

  resources :categories
  resources :shops

  get "/mcenter" => "mcenter#index"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end
