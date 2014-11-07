Rails.application.routes.draw do
  root :to => "home#index"

  namespace :admin do
    resource :dashboard, :only => [:show]
    resources :users, :only => [:index]
    resources :rants, :only => [:index]
  end

  resource :dashboard, :only => [:show]
  resource :session, :only => [:new, :create, :destroy]

  resources :users, :only => [:show, :new, :create, :edit, :update]
  resources :followings, :only => [:index, :create, :destroy]
  resources :rants, :only => [:show, :new, :create, :destroy] do
    member do
      post :spam
    end
    resources :favorites, :only => [:create, :destroy]
    resources :comments, :only => [:create]
  end

  resources :favorites, :only => [:index]

  resource :search
end
