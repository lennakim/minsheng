Minsheng::Application.routes.draw do
  get "/mcenter" => "mcenter#index"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users

  namespace :admin do
    resources :notices
  end
end
