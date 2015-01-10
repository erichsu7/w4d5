Rails.application.routes.draw do
  root "subs#index"
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:create, :destroy]
  end

  resources :posts, only: [:show, :new, :create, :edit, :update] do
    resources :comments, only: [:new]
  end
  resources :post_subs, only: [:create, :destroy]
  resources :comments, only: [:create]
end
