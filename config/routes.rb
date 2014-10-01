Rails.application.routes.draw do
  root :to => "home#index"

  resource :dashboard, :only => [:show]
  resource :session, :only => [:new, :create]
  resources :users, :only => [:new, :create]
end
