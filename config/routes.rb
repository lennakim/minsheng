Minsheng::Application.routes.draw do
  resources :shop_images


  mount Ckeditor::Engine => '/ckeditor'

  namespace :admin do
    resources :categories
    resources :shops
    resources :tags
    resources :users
    resources :shop_images
  end

  resources :categories
  resources :shops

  get "/mcenter" => "mcenter#index"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :registrations => "devise/registrations" }
  resources :users
end
