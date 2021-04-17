Rails.application.routes.draw do
  scope module: :public do
    root :to => 'homes#top'
    get '/about' => 'homes#about'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete 'cart_items/destroy_all'
    get 'customers/my_page' => 'customers#show'
    resource :customers, only: [:edit, :update]
    get 'customers/unsubscribe'
    patch 'customers/withdraw'
    get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/confirm'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    root :to => 'homes#top'
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
