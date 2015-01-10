Rails.application.routes.draw do
  root "subs#index"
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:create, :destroy]
  end

  resources :posts, only: [:show, :new, :create, :edit, :update]
  resources :post_subs, only: [:create, :destroy]
end
