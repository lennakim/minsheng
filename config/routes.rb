Minsheng::Application.routes.draw do

  resources :favors

  namespace :mobile do
    resources :shops
    resources :shop_images do
      collection do
        get :show_images
      end
    end
    resources :products
    resources :promos
    get "home" => 'home#main'
    get "home/index"
    get "home/search"
    get "users/phone_sign_up"
    get "users/email_sign_up"
    get "users/sign_in"
    get "users/check_username"
    get "users/check_mobile"
    get "users/check_mobile_code"
    get "users/check_email"
    get "users/check_mobile_exist"
    get "users/check_mobile_password_token"
    post "users/create" => "users#create"

    get "users/retrieve_all" => "users#retrieve_all"
    get "users/phone_verify_password_token" => "users#phone_verify_password_token"

    get  "users/retrieve_phone_step_one" => "users#retrieve_phone_step_one"
    get  "users/send_reset_password_token" => "users#send_reset_password_token"
    get  "users/retrieve_phone_step_two" => "users#retrieve_phone_step_two"
    post "users/phone_modify_password"
    get  "users/phone_reset_password_succcess" => "users#phone_reset_password_succcess"

    get "users/retrieve_email_step_one" => "users#retrieve_email_step_one"
    get "users/email_reset_password_succcess" => "users#email_reset_password_succcess"

    get "user_center/index"
    get "user_center/favorite"
    get "user_center/comment"
    get "user_center/foot_print"
    get "user_center/system_message"
    get "user_center/edit_info"
    get "user_center/edit_image"
    get "user_center/edit_password"

    get "users/send_captcha_code" => "users#send_captcha_code"
    get "users/verify_mobile" => "users#verify_mobile"
    # get "users/reset_password_page" => "users#reset_password_page"
    # get "users/send_password_token" => "users#send_password_token"
    post "users/reset_password" => "users#reset_password"
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

  devise_for :users, :controllers => { :registrations => "devise/registrations",
    :omniauth_callbacks => "devise/omniauth_callbacks", :sessions => "devise/sessions",
    :confirmations => "devise/confirmations" }

  resources :users do
    member do
      get :upload_image
    end
  end

  resources :notices, only: [:index, :show]

  resources :suggestions, only: :create
end
