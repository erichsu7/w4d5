Rails.application.routes.draw do
  root "subs#index"
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:create, :destroy]
  end

  resources :posts, only: [:show, :new, :create, :edit, :update] do
    resources :comments, only: [:new]
    member do
      post 'upvote'
      post 'downvote'
    end
  end
  resources :post_subs, only: [:create, :destroy]
  resources :comments, only: [:show, :create, :destroy] do
    member do
      post 'upvote'
      post 'downvote'
    end
  end
end
