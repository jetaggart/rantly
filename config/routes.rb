Rails.application.routes.draw do
  root :to => "home#index"

  resource :dashboard, :only => [:show]
  resource :session, :only => [:new, :create, :destroy]

  resources :users, :only => [:show, :new, :create, :edit, :update]
  resources :followings, :only => [:index, :create, :destroy]
  resources :rants, :only => [:show, :new, :create, :destroy]
end
