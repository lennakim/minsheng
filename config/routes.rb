Minsheng::Application.routes.draw do

  resources :product_images


  # resources :products


  match "/images/upload/:model/:field_name/:id/:filename" => "gridfs#serve"

  match "/userimages/uploads/*path" => "gridfs#userimage"


  match "admin/cities" => "admin/communities#cities"
  match "admin/cities/:city_id/districts" => "admin/communities#districts"

  resources :shop_images

  get 'tags/:tag', to: 'admin/shops#index', as: :tag

  mount Ckeditor::Engine => '/ckeditor'

  namespace :admin do
    resources :categories do
      member do
        get :children
      end
    end

    resources :shops do
      get 'rate-page/:page', action: :show, on: :member
      resources :rates, only: :show
    end

    resources :tags, except: :show

    resources :users do
      member do
        get :edit_role
        put :update_role
      end
    end

    resources :shop_images

    resources :notices

    resources :page_ads

    resources :friendly_links

    resources :shop_recommendations, except: :show

    resources :districts, only: :show do
      resources :communities
    end

    resources :products
  end

  resources :categories

  resources :shops do
    get 'rate-page/:page', action: :show, on: :member
    resources :rates
  end

  get "/admin" => "admin/mcenter#index"

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"

  devise_for :users, :controllers => { :registrations => "devise/registrations",:omniauth_callbacks => "devise/omniauth_callbacks" }

  resources :users do
    member do
      get :upload_image
    end
  end

  resources :notices, only: [:index, :show]
end
