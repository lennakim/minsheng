Minsheng::Application.routes.draw do

  resources :shop_images

  get 'tags/:tag', to: 'admin/shops#index', as: :tag

  mount Ckeditor::Engine => '/ckeditor'

  namespace :admin do
    resources :categories
    resources :shops do
      resources :rates
    end
    resources :tags
    resources :users do
      member do
        get :edit_role
        put :update_role
      end
    end
    resources :shop_images
    resources :notices
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

  resources :notices, only: [:index, :show]
end
