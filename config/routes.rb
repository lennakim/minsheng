Minsheng::Application.routes.draw do

  resources :favors
  namespace :mobile do
    resources :shops
    resources :shop_images
    resources :products
    resources :promos
    get "home" => 'home#index'
    get "users/sign_up"
    get "users/sign_in"

    get "retrieve"
    get "password_token"
    get "verify_password_token"
    get "retrieve02"
    get "retrieve03"
    post "reset_user_password"
    get "retrieve04"
    get "retrieve05"
    get "retrieve06"

    get "user_center/index"
    get "user_center/favorite"
    get "user_center/comment"
    get "user_center/foot_print"
    get "user_center/system_message"
    get "user_center/edit_info"
    get "user_center/edit_image"
    get "user_center/edit_password"
  end

  get "ucenter" => 'ucenter#index'
  get "ucenter/suggestion"
  get "ucenter/inbox"
  get "ucenter/comment"
  get "ucenter/settings"
  get "ucenter/change_password"
  get "ucenter/favorite"
  get "ucenter/view_history"
  put "ucenter/update_password"
  get "ucenter/region_list"
  get "ucenter/send_sms"
  get "ucenter/verify_mobile_code"


  get "mobile/sign_up" => "mobile#sign_up"
  get "mobile/send_sms" => "mobile#send_sms"
  get "mobile/verify_mobile" => "mobile#verify_mobile"
  post "mobile/create" => "mobile#create"
  get "mobile/reset_password_page" => "mobile#reset_password_page"
  get "mobile/send_password_token" => "mobile#send_password_token"
  post "mobile/reset_password" => "mobile#reset_password"

  resources :notifications do
    collection do
      get :own_sent
      get :read_infos
    end

    member do
      get :reply
      put :have_read
    end
  end

  resources :product_images

  # resources :products

  match "/images/upload/:model/:field_name/:id/:filename" => "gridfs#serve"

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

    resources :promos
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

  resources :suggestions, only: :create
end
