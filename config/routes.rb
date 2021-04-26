Rails.application.routes.draw do

  devise_for :customers, skip: :all
  devise_scope :customer do
    get 'customers/sign_in' => 'public/sessions#new', as: 'new_customer_session'
    post 'customers/sign_in' => 'public/sessions#create', as: 'customer_session'
    delete 'customers/sign_out' => 'public/sessions#destroy', as: 'destroy_customer_session'
    get 'customers/sign_up' => 'public/registrations#new', as: 'new_customer_registration'
    post 'customers' => 'public/registrations#create', as: 'customer_registration'
  end

  scope module: :public do
    root :to => 'homes#top'
    get '/about' => 'homes#about'
    resources :items, only: [:index, :show] do
      collection do
        get 'search'
      end
    end
    delete 'cart_items/destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]
    get 'customers/my_page' => 'customers#show'
    resource :customers, only: [:edit, :update]
    get 'customers/unsubscribe'
    patch 'customers/withdraw'
    get 'orders/complete' => 'orders#complete', as: 'orders_complete'
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/confirm'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admin/sign_in' => 'admin/sessions#new', as: 'new_admin_session'
    post 'admin/sign_in' => 'admin/sessions#create', as: 'admin_session'
    delete 'admin/sign_out' => 'admin/sessions#destroy', as: 'destroy_admin_session'
  end

  namespace :admin do
    root :to => 'homes#top'
    resources :homes, only: [:top] do
      collection do
        get 'search'
      end
    end
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    post 'items/search'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    post 'customers/search'
    resources :order_details, only: [:update]
    resources :orders, only: [:show, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end